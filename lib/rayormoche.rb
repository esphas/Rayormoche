require 'rayormoche/version'
require 'optparse'
require 'logger'

# The Main Rayormoche Module
module Rayormoche
  autoload :Application, 'rayormoche/application'
  autoload :Command,     'rayormoche/command'
  autoload :Option,      'rayormoche/option'

  # Public: Setup a new application and run.
  #
  # name - the name of the application
  #
  # Returns nil.
  def self.apply name
    app = Application.new name
    yield app
    app.execute ARGV
  end
end
