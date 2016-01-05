# A command has subcommands, options, arguments, an action and some other attributes that matter less.
#
# So a Rayormoche::Command has subcommands:Command, options:Option, arguments along with Option,
# an action and some other attributes.
class Rayormoche::Command

  DefaultSyntax        = "<command> [commands] [options]"

  RunSubcommandFound   = "Found subcommand: "
  RunWithArguments     = "No subcommand found, execute with current arguments: "
  ParseOptionSuccess   = "Successfully parsed arguments, [options, args]: "

  WarnCommandNameExist = "Command Name Already Exist!"
  WarnOptionKeyExist   = "Option Key Already Exist!"

  ErrorInvalidOption   = "0x0 we cannot understand your command: "
  ErrorNoAction        = "0w0 there is no action specified with this command"

  attr_reader :name
  attr_accessor :description, :syntax

  # Initialize a Command with a name and hashes of subcommands and options.
  #
  # @param cmdname [Symbol, String] name of the command
  # @param parent [Rayormoche::Command] parent command of the command
  def initialize cmdname, parent
    @name        = cmdname
    @parent      = parent
    @aliases     = []
    @description = ""
    @syntax      = DefaultSyntax
    @commands    = {}
    @options     = {}
  end

  # Get the fullname of the command.
  #
  # @return [String] the fullname formatted as "application ancestor parent command"
  def fullname
    pre = @parent ? @parent.fullname + ?\s : ""
    pre + @name.to_s
  end

  # (see Rayormoche::Application#logger)
  def logger
    @parent.logger
  end

  # Normalize names.
  #
  # @param name [String, Symbol] name to be normalize
  #
  # @return [Symbol] the normalized name that is used in the *Application* and *Command* class
  def normalize name
    name.to_s.downcase.to_sym
  end

  # Alias a command name to be attached to the parent command for self.
  #
  # @note when aliasing on an existing name, a *warn* will be sent to *logger* and then *alias* will continue.
  #
  # @param aliasname [Symbol, String] the name to alias with
  #
  # @return [Symbol] normalized alias
  def alias aliasname
    aliasname = normalize aliasname
    logger.warn WarnCommandNameExist if @parent.has_command? aliasname
    @aliases.push aliasname
    aliasname
  end

  # Get all names of the command, aliases included.
  #
  # @return [Array<Symbol>] an array of the name and aliases
  def names
    @aliases.clone << @name
  end

  # Get a one-line summury of the command.
  #
  # @return [String] formatted summury for the command
  def summury
    ?\s * 2 + names.join(?, + ?\s).ljust(20) + ?\s * 2 + @description
  end

  # Create new subcommand.
  #
  # @param cmdname (see #initialize)
  #
  # @return [Rayormoche::Command] the command created
  def command cmdname
    cmdname = normalize cmdname
    logger.warn WarnCommandNameExist if @commands[cmdname]
    subcommand = Rayormoche::Command.new cmdname, self
    yield subcommand if block_given?
    @commands[cmdname] = subcommand
  end

  # Get subcommand via name or alias.
  #
  # @param cmdname [Symbol, String] the name or alias of the command
  #
  # @return [Rayormoche::Command, nil] the command found or nil
  def get_command cmdname
    @commands.each_value do |cmd|
      return cmd if cmd.names.include? normalize cmdname
    end
    return nil
  end

  # Get a list of all subcommands' names, aliases included.
  #
  # @return [Array<Symbol>] an array of the names and aliases
  def commands
    @commands.values.map &:names
  end

  # Check whether a subcommand named cmdname exists.
  #
  # @param cmdname (see #initialize)
  #
  # @return true for existence
  def has_command? cmdname
    commands.flatten.include? normalize cmdname
  end

  # Create new option.
  #
  # @param (see Rayormoche::Option#initialize)
  #
  # @note The *optparse* is a standard ruby library.
  #
  # @return [Rayormoche::Option] the option created
  def option optkey, *switches
    optkey = normalize optkey
    logger.warn WarnOptionKeyExist if @options[optkey]
    option = Rayormoche::Option.new optkey, *switches
    yield option if block_given?
    @options[optkey] = option
  end

  # Get a list of all options.
  #
  # @return [Array<Symbol>] an array of the keys
  def options
    @options.keys
  end

  # TODO: present Usage
  def usage
  end

  # Set the action of the command, receives a block.
  #
  # Parsed arguments of options (Hash) will be passed to the action as the first parameter.
  #
  # Remaining unparsed arguments (Array) will be passed to the action as the second parameter.
  #
  # @param &actprc [Proc] the action to be performed
  #
  # @return [Proc] the actprc passed in
  def action &actprc
    @action = actprc
  end

  # Setup Option Parser
  #
  # @param (see #run)
  #
  # @return [[Hash, Array]] an array with two elements, the first is parsed options in *Hash*,
  #  and the second is the remaining unparsed arguments in *Array*
  def parse_options argv
    result = {}
    opts = OptionParser.new do |opts|
      @options.each_value do |option| opts.on *option.switches do |rv| result[option.key] = rv end end
    end
    begin
      opts.parse! argv
    rescue OptionParser::InvalidOption => e
      logger.error [ErrorInvalidOption, ?\n, ?\t, e.message, ?\n, usage].join
      abort
    end
    logger.debug ParseOptionSuccess
    logger.debug [result, argv].inspect
    [result, argv]
  end

  # Run the command or one of its subcommands.
  #
  # @param argv [Array<String>] the array of the arguments in *String*
  #
  # @return (see Rayormoche.apply)
  def run argv = []
    if has_command? argv[0]
      subcommand = get_command normalize argv.shift
      logger.debug RunSubcommandFound + subcommand.name.to_s
      subcommand.run argv
    else
      if @action.nil?
        logger.error ErrorNoAction
        abort
      end
      logger.debug RunWithArguments + argv.inspect
      options, args = parse_options argv
      @action.call options, args
    end
  end
end
