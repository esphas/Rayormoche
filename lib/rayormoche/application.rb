# An application behaves similarly to a command, so *Rayormoche::Application* takes *Rayormoche::Command* as superclass.
#
# Unlike normal *Command*s, an *Application* does not have parent command,
# which means what does an *Application* name does not really matter.
#
# For more details, see *Rayormoche::Command*.
class Rayormoche::Application < Rayormoche::Command

  LoggerLevel = Logger::INFO

  # Initialize an application with a name.
  #
  # @note The name of the *Application* does not really matter the functioning -
  #  it only influence the prompt message.
  def initialize appname
    super appname, nil
  end

  # Get a logger.
  #
  # @note The *logger* in *Rayormoche::Command* will simply call its parent's *logger*,
  #  which makes the logger created in *Rayormoche::Application* the only logger.
  #
  # @note The *logger* is a standard ruby library.
  #
  # @return [Logger] a logger that outputs to *STDOUT*
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
