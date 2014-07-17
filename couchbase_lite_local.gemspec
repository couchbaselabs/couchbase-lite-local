# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'couchbase_lite_local/version'

Gem::Specification.new do |spec|
  spec.name          = "couchbase_lite_local"
  spec.version       = CouchbaseLiteLocal::VERSION
  spec.authors       = ["Philipp Fehre"]
  spec.email         = ["philipp.fehre@googlemail.com"]
  spec.description   = %q{expose a local instance of couchbase lite via http}
  spec.summary       = %q{exposes a local instance of couchbase lite on port 5984 (default) over http}
  spec.homepage      = "http://github.com/couchbaselabs/couchbase_lite_local"
  spec.license       = "APACHE"

  spec.platform      = Gem::Platform::CURRENT
  spec.required_rubygems_version = ">= 1.9.3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "warbler"
  spec.add_development_dependency "rake"
end
