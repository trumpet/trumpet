# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{trumpet}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Taras"]
  s.date = %q{2009-05-18}
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
    "lib/trumpet.rb",
    "lib/trumpet/base.rb",
    "lib/trumpet/channel.rb",
    "lib/trumpet/delegator.rb",
    "lib/trumpet/exceptions.rb",
    "lib/trumpet/helpers.rb",
    "lib/trumpet/listener.rb",
    "lib/trumpet/message.rb",
    "lib/trumpet/receiver.rb",
    "lib/trumpet/request.rb",
    "lib/trumpet/resource.rb",
    "lib/trumpet/transmitter.rb",
    "lib/trumpet/user.rb",
    "spec/channel_spec.rb",
    "spec/fixtures/channels/all",
    "spec/fixtures/channels/create",
    "spec/fixtures/channels/messages",
    "spec/fixtures/channels/show",
    "spec/fixtures/listeners/create",
    "spec/fixtures/listeners/find",
    "spec/fixtures/listeners/im",
    "spec/fixtures/listeners/irc",
    "spec/fixtures/listeners/sms",
    "spec/fixtures/listeners/twitter",
    "spec/fixtures/receivers/create",
    "spec/fixtures/receivers/find",
    "spec/fixtures/receivers/messages",
    "spec/fixtures/transmitters/create",
    "spec/fixtures/transmitters/find",
    "spec/fixtures/users/channels",
    "spec/fixtures/users/create",
    "spec/fixtures/users/listeners",
    "spec/fixtures/users/put",
    "spec/fixtures/users/receivers",
    "spec/fixtures/users/show",
    "spec/listener_spec.rb",
    "spec/message_spec.rb",
    "spec/receiver_spec.rb",
    "spec/request_spec.rb",
    "spec/spec_helper.rb",
    "spec/transmitter_spec.rb",
    "spec/user_spec.rb"
  ]
  s.homepage = %q{http://github.com/trumpet/trumpet}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{The official trumpet gem}
  s.test_files = [
    "spec/channel_spec.rb",
    "spec/listener_spec.rb",
    "spec/message_spec.rb",
    "spec/receiver_spec.rb",
    "spec/request_spec.rb",
    "spec/spec_helper.rb",
    "spec/transmitter_spec.rb",
    "spec/user_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end
