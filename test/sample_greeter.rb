require 'rayormoche'

# We have built an app nameed 'Greeter': Greeter will say hello to you.

class Greeter

  Dir.mkdir 'tmp' unless FileTest.exist? 'tmp'

  @@friends = "tmp/greeter_friends.tmp"

  open @@friends, 'w' do end unless FileTest.exist? @@friends

class << self

# A Greeter can mark a certain person as friend. Once makred, all Greeters can recognize.
  def friend person
    friends = open(@@friends, 'r', &:read).split ?,
    if friends.include? person
      # do something perhaps
    else
      friends.push person
      open(@@friends, 'w'){|f| f.write friends.join ?,}
    end
  end

# A Greeter can say hello to somebody.
  def greet person
    puts "Hello, my dear friend #{person}! Glad to see you!"
  end

# A Greeter can mark somebody as not friendly if neccessary.
  def unfriend person
    friends = open(@@friends, 'r', &:read).split ?,
    friends.delete person
    open(@@friends, 'w'){|f| f.write friends.join ?,}
  end

# However, a Greeter can not mark anybody as enemy of the disliked because he is Greeter.

# A Greeter will try to make friends with somebody who is not a friend yet.
  def askfriend person
    puts "Hello, #{person}! Glad to meet you, how about make a friend today?"
    puts "Use 'friend' to make friends."
  end

# A Greeter will choose an action to perform when he meets people.
  def meet person
    friends = open(@@friends, 'r', &:read).split ?,
    if friends.include? person
      greet person
    else
      askfriend person
    end
  end
end
end

# Now lets teach Greeter how to use Rayormoche to communicate with lots of his potential friends easier.

# Create a Appication named greeter..
Rayormoche.apply :greeter do |app|

  # - Add a command named meet..
  app.command :meet do |cmd|

    # -- Add option: -f --friend
    cmd.option :friend, "-f", "--friend", "make friend with NAME."
    # -- Add option: -F --unfriend
    cmd.option :unfriend, "-F", "--unfriend", "unfriend NAME."

    # --= When this command is triggered, options and unparsed other arguments will be passed to an action.
    cmd.action do |options, args|
      name = args[0]
      Greeter.unfriend name if options[:unfriend]
      Greeter.friend name if options[:friend]
      Greeter.meet name
    end
  end

  # - Add another command named friend..
  app.command :friend do |cmd|

    # -- This command does not have options

    # -- This command has an alias: make-friend
    cmd.alias :make_friend

    #-- If you try alias a existing name, there will be a info message.
    # cmd.alias "make-friend"

    # --= This command also has an action.
    cmd.action do |_, args|
      name = args[0]
      Greeter.friend name
    end
  end

  # - Add yet another command named unfriend..
  app.command :unfriend do |cmd|

    # --= An action of course.
    cmd.action do |_, args|
      name = args[0]
      Greeter.unfriend name
    end
  end
end

# Now our Greeter learned how to use Rayormoche!
