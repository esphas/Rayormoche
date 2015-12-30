require 'rayormoche'

Rayormoche.apply :halo do |app|
  app.command :say do |cmd|
    cmd.option :name, "-n", "--name", "the name to be greeted!"
    cmd.action do |argv, opts|
      puts argv
      puts "Hello, #{opts[:name]}"
    end
  end
end
