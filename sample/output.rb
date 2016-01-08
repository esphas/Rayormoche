require 'rayormoche'

Rayormoche.apply :test_output do |app|

  app.command :command do |cmd|
    cmd.option :noarg, '-e'
    cmd.option :arg, '-p MESSAGE', String
    cmd.action do |opts, _|
      puts "Option without argument!" if opts[:noarg]
      puts "Hello, #{opts[:arg]}! Argumented!" if opts[:arg]
      puts "Succeeded!"
    end
  end

  app.action do |_, args|
    puts "The action of the application. No subcommands or options. args: #{args}"
  end
end
