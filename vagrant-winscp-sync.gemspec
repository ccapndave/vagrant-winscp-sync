# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-winscp-sync/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-winscp-sync"
  spec.version       = VagrantPlugins::WinSCP::VERSION
  spec.authors       = ["Dave Keen"]
  spec.email         = []
  spec.description   = %q{A Vagrant plugin for syncing files on Windows via WinSCP instead of shared folders}
  spec.summary       = %q{A Vagrant plugin for syncing files on Windows via WinSCP instead of shared folders}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
