# frozen_string_literal: true

require_relative 'lib/codebreaker/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.2')

  spec.name          = 'codebreaker'
  spec.version       = Codebreaker::VERSION
  spec.authors       = ['TurVitAn']
  spec.email         = ['turzhansky81@gmail.com']

  spec.summary       = 'Codebreaker console game through user interaction'
  spec.homepage      = 'https://github.com/Turzhanskyi/codebreaker-rg'
  spec.license       = 'MIT'
  spec.require_paths = 'lib'

  spec.add_development_dependency 'fasterer', '~> 0.8.3'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.3'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'rubocop', '~> 1.8', '>= 1.8.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.1'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'

  spec.files = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
end
