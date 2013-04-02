# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/jabber/notifications/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-jabber-notifications"
  spec.version       = Capistrano::Jabber::Notifications::VERSION
  spec.authors       = ["Pavel Lazureykis"]
  spec.email         = ["lazureykis@gmail.com"]
  spec.description   = %q{Sending notifications about deploy to jabber}
  spec.summary       = %q{Sending notifications about deploy to jabber}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'xmpp4r', '=0.5'
end
