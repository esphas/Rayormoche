require 'rayormoche'

Rayormoche.apply :halo do |app|
  app.command :greet do |cmd|
    cmd.option :name, "-n NAME", "--name", "the name to be greeted!", String
    cmd.action do |options|
      puts "Hello, #{options[:name]}!"
    end
  end
end
