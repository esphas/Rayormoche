##
# Rayormoche Application
#
# An application behaves similarly to a command, so Rayormoche::Application takes Rayormoche::Command as superclass.
# Unlike normal Command, an Application does not have parent command,
# which means what does an Application name does not really matter.
# For more details, see Rayormoche::Command.
class Rayormoche::Application < Rayormoche::Command

  ##
  # Initialize an application with a name
  def initialize appname
    super appname, nil
  end
end
