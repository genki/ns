require 'optparse'
require 'singleton'
require 'socket'

class Ns
  VERSION = "0.1.0"

  include Singleton

  class << self
    def run
      action = :list
      opt = OptionParser.new
      opt.on('-k', 'kill'){action = :kill}
      opt.order!(ARGV)
      instance.send action, ARGV
    end
  end

  def list(ports)
    system 'lsof', *ports.map{|i| "-i:#{i}"}
  end

  def kill(ports)
    puts "ports required" or exit if ports.empty?
    lines = `lsof#{ports.map{|i| " -i:#{i}"}}`.split("\n")[1..-1]
    lines.each do |line|
      pid = line.split(/\s+/)[1]
      if system "kill -#{@signal || '9'} #{pid}"
        puts "#{pid} killed."
      else
        puts "#{pid} not killed."
      end
    end unless lines.nil?
  end
end
