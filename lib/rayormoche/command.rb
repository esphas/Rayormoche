##
# Rayormoche Command
#
# A command has subcommands, options, arguments, an action and some other attributes that matter less.
#
# So a Command has subcommands:Command, options:Option, arguments along with Option,
# an action and some other attributes.
module Rayormoche
  class Command

    DefaultSyntax        = "<command> [commands] [options]"
    InfoCommandNameExist = "Command Name Already Exist!"
    LoggerLevel          = Logger::INFO

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
      add_default_options
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
      # TODO:
    end

    ##
    # Normalize names.
    def normalize name
      strname = name.to_s
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
    def option optkey, *optinfo
      optkey = normalize optkey
      @options[optkey] = Option.new optkey, optinfo
      yield @commands[optkey] if block_given?
      @options[optkey]
    end

    ##
    # Add default options to the command.
    def add_default_options
      # TODO: -h, --help
    end

    ##
    # Get a list of all options.
    def options
      @options.each_value.entries.uniq
    end

    ##
    # Set the action of the command, receives a block.
    # The ARGV (Array) will be passed to the action as the first parameter.
    # Parsed arguments of options (Hash) will be passed to the action as the second parameter.
    def action &actprc
      @action = actprc
    end

    ##
    # Run the command or one of its subcommands.
    def run argv = [], options = {}
      # TODO:
    end
  end
end
