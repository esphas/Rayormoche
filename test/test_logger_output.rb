require 'rayormoche'

Rayormoche.apply :logger do |app|

  app.command :no_action do |cmd|
  end

  app.command :success do |cmd|
    cmd.alias :overoverovername
    cmd.alias :overoverovername
    cmd.option :optovername
    cmd.option :optovername
    cmd.action do puts "success" end
  end
end
