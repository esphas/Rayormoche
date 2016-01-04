
task :default => %w[ greeter logger_output ]

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

task :logger_output => %w[ logger_output_1 logger_output_2 logger_output_3 ]

task :logger_output_1 do
  begin
    ruby 'test/test_logger_output.rb', 'success', '-i', 'Invalid Option'
    raise "Unexpected!"
  rescue => e
    raise if e.message == "Unexpected!"
    puts e.to_s[0, 60] + ?. * 3
  end
end

task :logger_output_2 do
  begin
    ruby 'test/test_logger_output.rb', 'no_action'
    raise "Unexpected!"
  rescue => e
    raise if e.message == "Unexpected!"
    puts e.to_s[0, 60] + ?. * 3
  end
end

task :logger_output_3 do
  ruby 'test/test_logger_output.rb', 'success'
end
