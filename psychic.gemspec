# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'psychic/version'

Gem::Specification.new do |spec|
  spec.name          = "psychic"
  spec.version       = Psychic::VERSION
  spec.authors       = ["Nao Minami"]
  spec.email         = ["south37777@gmail.com"]

  spec.summary       = %q{Get dynamic site's HTML}
  spec.homepage      = "https://github.com/south37/psychic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["psychic"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
