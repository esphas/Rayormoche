#
require_relative 'lib/rayormoche/version'

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
  rayormoche.files         = Dir['**/*'].grep(/^(bin|lib)\//)
  rayormoche.executables   = rayormoche.files.grep(/^bin\//){|n| File.basename n}

  rayormoche.add_development_dependency 'bundler'
  rayormoche.add_development_dependency 'rake'
end
