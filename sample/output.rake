multitask :output => 11.times.map{|i| "test_output_#{i}"}

task :test_output_0 do
  puts "# simplest command"
  ruby 'sample/output.rb'
end
task :test_output_1 do
  puts "# invalid option"
  ruby 'sample/output.rb', '-o' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_2 do
  puts "# not a command, takes as an argument"
  ruby 'sample/output.rb', 'nocommand'
end
task :test_output_3 do
  puts "# none-command with invalid option, should be the same with invalid option"
  ruby 'sample/output.rb', 'nocommand', '-o' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_4 do
  puts "# valid command"
  ruby 'sample/output.rb', 'command'
end
task :test_output_5 do
  puts "# further invalid option"
  ruby 'sample/output.rb', 'command', '-o' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_6 do
  puts "# further none-command"
  ruby 'sample/output.rb', 'command', 'nocommand' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_7 do
  puts "# valid command with valid option"
  ruby 'sample/output.rb', 'command', '-e'
end
task :test_output_8 do
  puts "# valid command with valid option but not arguments"
  ruby 'sample/output.rb', 'command', '-p' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_9 do
  puts "# valid command with valid option and arguments"
  ruby 'sample/output.rb', 'command', '-p', 'Esphas'
end
task :test_output_10 do
  puts "# valid command with valid options and arguments"
  ruby 'sample/output.rb', 'command', '-ep', 'Esphas'
end
