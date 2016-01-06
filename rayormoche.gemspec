
require File.expand_path '../lib/rayormoche/version', __FILE__

Gem::Specification.new do |rayormoche|
  rayormoche.name          = 'rayormoche'
  rayormoche.version       = Rayormoche::VERSION
  rayormoche.license       = 'MIT'

  rayormoche.summary       = 'A lightweight library for writing command line app'
  rayormoche.description   = 'Rayormoche is a lightweight library for writing command line app in Ruby.'

  rayormoche.authors       = ['Esphas Kueen']
  rayormoche.email         = 'esphas@hotmail.com'
  rayormoche.homepage      = 'https://github.com/esphas/rayormoche'

  rayormoche.require_paths = ['lib']
  rayormoche.files         = Dir['lib/**/*'].reject{|d| FileTest.directory? d}

  rayormoche.add_development_dependency 'bundler', '~> 1'
  rayormoche.add_development_dependency 'rake', '>= 0'

  rayormoche.required_ruby_version = '>= 1.9.3'
end
