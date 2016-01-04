##
# Rayormoche Application
#
# An application behaves similarly to a command, so Rayormoche::Application takes Rayormoche::Command as superclass.
# Unlike normal Command, an Application does not have parent command,
# which means what does an Application name does not really matter.
# For more details, see Rayormoche::Command.
class Rayormoche::Application < Rayormoche::Command

  LoggerLevel = Logger::INFO

  ##
  # Initialize an application with a name
  def initialize appname
    super appname, nil
  end

  ##
  # Get a logger
  # The logger in Application is the only original logger.
  def logger
    return @logger if @logger
    @logger = Logger.new STDOUT
    @logger.level = LoggerLevel
    @logger.formatter = proc do |severity, _, _, msg|
      insert = severity == 'ERROR' ? ?: : [?\s, severity.downcase, ?:, ?\n, ?\s].join
      [fullname, insert, ?\s, msg.to_s, ?\n].join
    end
    @logger
  end
end
