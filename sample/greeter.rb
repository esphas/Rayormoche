require 'rayormoche'

class Greeter

  @@friends = 'tmp/greeter_friends.tmp'

  Dir.mkdir 'tmp' unless Dir.exist? 'tmp'
  File.open @@friends, ?w do end unless FileTest.exist? @@friends

  class << self
    def friend person
      friends = open(@@friends, 'r', &:read).split ?,
      if friends.include? person
        # do something perhaps
      else
        friends.push person
        open(@@friends, 'w'){|f| f.write friends.join ?,}
      end
    end

    def greet person
      puts "Hello, my dear friend #{person}! Glad to see you!"
    end

    def unfriend person
      friends = open(@@friends, 'r', &:read).split ?,
      friends.delete person
      open(@@friends, 'w'){|f| f.write friends.join ?,}
    end

    def askfriend person
      puts "Hello, #{person}! Glad to meet you, how about make a friend today?"
      puts "Use 'friend' to make friends."
    end

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


Rayormoche.apply :greeter do |app|

  app.command :meet do |cmd|

    cmd.option :friend, "-f", "--friend", "make friend with NAME."
    cmd.option :unfriend, "-F", "--unfriend", "unfriend NAME."

    cmd.action do |options, args|
      name = args[0]
      Greeter.unfriend name if options[:unfriend]
      Greeter.friend name if options[:friend]
      Greeter.meet name
    end
  end

  app.command :friend do |cmd|

    cmd.alias :make_friend

    cmd.action do |_, args|
      name = args[0]
      Greeter.friend name
    end
  end

  app.command :unfriend do |cmd|

    cmd.action do |_, args|
      name = args[0]
      Greeter.unfriend name
    end
  end
end
