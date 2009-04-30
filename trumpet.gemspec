# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{trumpet}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Taras"]
  s.date = %q{2009-04-30}
  s.email = %q{wtf@trumpet.io}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/core_extensions.rb",
    "lib/http.rb",
    "lib/trumpet.rb",
    "lib/trumpet/channel.rb",
    "lib/trumpet/exceptions.rb",
    "lib/trumpet/listener.rb",
    "lib/trumpet/message.rb",
    "lib/trumpet/receiver.rb",
    "lib/trumpet/sieve.rb",
    "lib/trumpet/transmitter.rb",
    "lib/trumpet/trumpet_resource.rb",
    "lib/trumpet/user.rb",
    "spec/spec_helper.rb",
    "spec/trumpet_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/trumpet/trumpet}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{The official trumpet gem}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/trumpet_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<resourceful>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<resourceful>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<resourceful>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
