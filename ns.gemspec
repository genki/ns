# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ns}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Genki Takiuchi"]
  s.date = %q{2009-02-18}
  s.default_executable = %q{ns}
  s.description = %q{Net}
  s.email = %q{genki@s21g.com}
  s.executables = ["ns"]
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "ChangeLog", "Rakefile", "bin/ns", "test/ns_test.rb", "test/test_helper.rb", "lib/ns.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://ns.rubyforge.org}
  s.rdoc_options = ["--title", "ns documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ns}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Net}
  s.test_files = ["test/ns_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redgreen>, [">= 1.2.1"])
    else
      s.add_dependency(%q<redgreen>, [">= 1.2.1"])
    end
  else
    s.add_dependency(%q<redgreen>, [">= 1.2.1"])
  end
end
