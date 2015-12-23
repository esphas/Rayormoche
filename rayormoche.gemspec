#
require 'reyormoche/version'

Gem::Specification.new do |reyormoche|
  reyormoche.name          = 'reyormoche'
  reyormoche.version       = Rayormoche::VERSION
  reyormoche.license       = 'MIT'

  reyormoche.summary       = "A lightweight library for writing command line app"
  reyormoche.description   = "Rayormoche is a lightweight library for writing command line app in Ruby."

  reyormoche.authors       = ["Esphas Kueen"]
  reyormoche.email         = 'esphas@hotmail.com'
  reyormoche.homepage      = 'https://github.com/esphas/reyormoche'

  reyormoche.require_paths = ['lib']
  reyormoche.files         = Dir["**/*"].grep(/^(bin|lib)\//)
  reyormoche.executables   = reyormoche.files.grep(/^bin\//){|n| File.basename n}
end
