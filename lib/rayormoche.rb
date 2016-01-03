require 'rayormoche/version'
require 'optparse'
require 'logger'

# The Main Rayormoche Module
module Rayormoche
  autoload :Application, 'rayormoche/application'
  autoload :Command,     'rayormoche/command'
  autoload :Option,      'rayormoche/option'

  ##
  # Setup a new application and run.
  def self.apply name
    app = Application.new name
    yield app
    app.run ARGV
  end
end
