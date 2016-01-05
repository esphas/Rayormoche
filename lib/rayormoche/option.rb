# A option defines a certain argument, and has one or more switches, a return value and so on.
#
# So a Rayormoche::Option has a key:Symbol, which specify the Option uniquely under its parent Command.
# A Option also has a switches:(String)Array,
# and the work to figure out what do these Strings mean is left for OptionParser.
class Rayormoche::Option

  attr_reader :key, :switches

  # Initialize the Option with a name and a description
  #
  # @param optkey [Symbol, String] the key that identify the option
  # @param *switches [String] the switches used for *OptionParser*
  def initialize optkey, *switches
    @key = optkey
    @switches = switches
  end

  # TODO: present option in a readable way, something like instructions maybe
end
