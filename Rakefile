
task :default => :test

task :test => %w[ test_output ]

task :greeter do
  ruby 'test/sample_greeter.rb', 'meet', 'Esphas'
  ruby 'test/sample_greeter.rb', 'meet', '-f', 'Esphas'
  ruby 'test/sample_greeter.rb', 'meet', 'Esphas'
  ruby 'test/sample_greeter.rb', 'unfriend', 'Esphas'
  ruby 'test/sample_greeter.rb', 'meet', 'Esphas'
  ruby 'test/sample_greeter.rb', 'friend', 'Esphas'
  ruby 'test/sample_greeter.rb', 'meet', 'Esphas'
  ruby 'test/sample_greeter.rb', 'unfriend', 'Esphas'
  ruby 'test/sample_greeter.rb', 'make-friend', 'Esphas'
  ruby 'test/sample_greeter.rb', 'meet', 'Esphas'
  ruby 'test/sample_greeter.rb', 'unfriend', 'Esphas'
end

multitask :test_output => 11.times.map{|i| "test_output_#{i}"}

task :test_output_0 do
  puts "# simplest command"
  ruby 'test/output.rb'
end
task :test_output_1 do
  puts "# invalid option"
  ruby 'test/output.rb', '-o' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_2 do
  puts "# not a command, takes as an argument"
  ruby 'test/output.rb', 'nocommand'
end
task :test_output_3 do
  puts "# none-command with invalid option, should be the same with invalid option"
  ruby 'test/output.rb', 'nocommand', '-o' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_4 do
  puts "# valid command"
  ruby 'test/output.rb', 'command'
end
task :test_output_5 do
  puts "# further invalid option"
  ruby 'test/output.rb', 'command', '-o' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_6 do
  puts "# further none-command"
  ruby 'test/output.rb', 'command', 'nocommand' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_7 do
  puts "# valid command with valid option"
  ruby 'test/output.rb', 'command', '-e'
end
task :test_output_8 do
  puts "# valid command with valid option but not arguments"
  ruby 'test/output.rb', 'command', '-p' rescue puts $!.to_s[0, 40] + ?. *3
end
task :test_output_9 do
  puts "# valid command with valid option and arguments"
  ruby 'test/output.rb', 'command', '-p', 'Esphas'
end
task :test_output_10 do
  puts "# valid command with valid options and arguments"
  ruby 'test/output.rb', 'command', '-ep', 'Esphas'
end
