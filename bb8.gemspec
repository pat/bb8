# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bb8/version'

Gem::Specification.new do |spec|
  spec.name          = "bb8"
  spec.version       = BB8::VERSION
  spec.authors       = ["Pat Allan"]
  spec.email         = ["pat@freelancing-gods.com"]
  spec.licenses      = ['MIT']

  spec.summary       = %q{Manage and share Terraform variables, environments, and states securely.}
  spec.homepage      = "https://github.com/pat/bb8"

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |file| File.basename(file) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 0.10.0"

  spec.add_development_dependency "rspec", "~> 3.0"
end
