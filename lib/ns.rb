require 'optparse'
require 'singleton'
require 'socket'

class Ns
  VERSION = "0.0.3"
  Listener = Struct.new(:proto, :recvq, :sendq, :laddr, :raddr, :state, :prog)
  @@all = false

  include Singleton

  class << self
    def run
      action = :list
      opt = OptionParser.new
      opt.on('-k', 'kill'){action = :kill}
      opt.on('-a', 'all'){@@all = true}
      opt.order!(ARGV)
      instance.send action, ARGV
    end
  end

  def list(ports)
    @listeners.each do |l|
      unless ports.empty?
        next unless l.laddr.match(/[^\:]\:(?:#{ports.join('|')})\b/)
      end
      next if !@@all && (l.prog.nil? || l.prog == '-')
      next if l.laddr.split(':').size > 2
      puts "%18s  %18s  %s" % [l.laddr, l.raddr, l.prog]
    end
  end

  def kill(ports)
    puts "ports required" or exit if ports.empty?
    @listeners.each do |l|
      unless ports.empty?
        next unless l.laddr.match(/[^\:]\:(?:#{ports.join('|')})\b/)
      end
      next if l.laddr.split(':').size > 2
      next if l.prog.nil?
      pid, progname = l.prog.split('/', 2)
      system "kill -9 #{pid}"
      puts "%s(%s) killed" % [progname, pid]
    end
  end

private
  def initialize
    @listeners = []
    lines = `netstat -n -l -p 2>/dev/null`.split("\n")[1..-1]
    lines.grep(/^(tcp|udp)/).each do |line|
      @listeners << Listener.new(*line.split(/\s+/))
    end
  end
end
