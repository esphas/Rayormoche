require 'rayormoche/version'
require 'optparse'
require 'logger'

# The main *Rayormoche* module defines the interface of *Rayormoche*.
#
# *Rayormoche.apply* is the way *Rayormoche* functions.
#
# == Class Relationship Diagram
#     +---------+       +--------+
#     | Command |<>---+-| Option |
#     +---------+     | +--------+
#          A          |
#          |          |
#   +-------------+   |
#   | Application |<>-+
#   +-------------+
module Rayormoche
  autoload :Application, 'rayormoche/application'
  autoload :Command,     'rayormoche/command'
  autoload :Option,      'rayormoche/option'

  # Setup a new application and run.
  #
  # @param name [Symbol, String] the name of the application
  #
  # @return the output of the application with specific arguments
  def self.apply name
    app = Application.new name
    yield app
    app.run ARGV
  end
end
