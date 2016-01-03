##
# Rayormoche Command
#
# A command has subcommands, options, arguments, an action and some other attributes that matter less.
#
# So a Command has subcommands:Command, options:Option, arguments along with Option,
# an action and some other attributes.
class Rayormoche::Command

  LoggerLevel          = Logger::INFO
  DefaultSyntax        = "<command> [commands] [options]"
  InfoCommandNameExist = "Command Name Already Exist!"
  InfoOptionKeyExist   = "Option Key Already Exist!"
  RunSubcommandFound   = "Found subcommand: "
  RunWithArguments     = "No subcommand found, execute with current arguments: "

  attr_reader :name, :parent, :aliases
  attr_accessor :description, :syntax

  ##
  # Initialize a Command with a name and hashes of subcommands and options.
  def initialize cmdname, parent
    @name        = cmdname
    @parent      = parent
    @aliases     = []
    @description = ""
    @syntax      = DefaultSyntax
    @commands    = {}
    @options     = {}
  end

  ##
  # Get the fullname of the command.
  def fullname
    pre = @parent ? @parent.fullname + 32.chr : ""
    pre + @name.to_s
  end

  ##
  # Get a logger
  def logger level = LoggerLevel
    return @logger if @logger
    @logger = Logger.new STDOUT
    @logger.level = level
    @logger
  end

  ##
  # Normalize names.
  def normalize name
    strname = name.to_s.dup
    strname.downcase!
    strname.gsub! /_/, ?-
    strname.gsub! /^-+|-+$/, ""
    strname.to_sym
  end

  ##
  # Alias a command name to be attached to the parent command for self.
  def alias aliasname
    aliasname = normalize aliasname
    logger.info InfoCommandNameExist if @parent.has_command? aliasname
    @aliases.push aliasname
  end

  ##
  # Get all names of the command, aliases included.
  def names
    @aliases.clone << @name
  end

  ##
  # Get a one-line summury of the command.
  def summury
    32.chr * 2 + names.join(?,+32.chr).ljust(20) + 32.chr * 2 + @description
  end

  ##
  # Create new subcommand.
  def command cmdname
    cmdname = normalize cmdname
    logger.info InfoCommandNameExist if @commands[cmdname]
    @commands[cmdname] = Command.new cmdname, self
    yield @commands[cmdname] if block_given?
    @commands[cmdname]
  end

  ##
  # Get a list of all subcommands.
  def commands
    @commands.values.map &:names
  end

  ##
  # Check whether a subcommand named cmdname exists.
  def has_command? cmdname
    commands.flatten.include? normalize cmdname
  end

  ##
  # Getter of option, create if not exist.
  def option optkey, *switches
    optkey = normalize optkey
    logger.info InfoOptionKeyExist if @options[optkey]
    @options[optkey] = Option.new optkey, switches
    yield @options[optkey] if block_given?
    @options[optkey]
  end

  ##
  # Get a list of all options.
  def options
    @options.each_value.entries.uniq
  end

  ##
  # Set the action of the command, receives a block.
  # Parsed arguments of options (Hash) will be passed to the action as parameter.
  def action &actprc
    @action = actprc
  end

  ##
  # Setup Option Parser
  def parse_options argv
    result = {}
    OptionParser.new do |opts|
      @options.each_value do |option|
        opts.on *option.switches do |sr|
          result[option.key] = sr
        end
      end
    end.parse! argv
    result
  end

  ##
  # Run the command or one of its subcommands.
  def run argv = []
    if has_command? argv[0]
      subcommand = @commands[normalize argv.shift]
      logger.debug RunSubcommandFound + subcommand.name.to_s
      subcommand.run argv
    else
      logger.debug RunWithArguments + argv.inspect
      @action.call parse_options argv
    end
  end
end
