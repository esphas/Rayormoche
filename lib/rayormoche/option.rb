##
# Rayormoche Option
#
# A
class Rayormoche::Option

  attr_reader :key, :switches

  ##
  # Initialize the Option with a name and a description
  def initialize optkey, switches
    @key = optkey
    @switches = switches
    # TODO:
  end
end
