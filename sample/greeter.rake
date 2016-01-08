task :greeter do
  ruby 'sample/greeter.rb', 'meet', 'Esphas'
  ruby 'sample/greeter.rb', 'meet', '-f', 'Esphas'
  ruby 'sample/greeter.rb', 'meet', 'Esphas'
  ruby 'sample/greeter.rb', 'unfriend', 'Esphas'
  ruby 'sample/greeter.rb', 'meet', 'Esphas'
  ruby 'sample/greeter.rb', 'friend', 'Esphas'
  ruby 'sample/greeter.rb', 'meet', 'Esphas'
  ruby 'sample/greeter.rb', 'unfriend', 'Esphas'
  ruby 'sample/greeter.rb', 'make-friend', 'Esphas'
  ruby 'sample/greeter.rb', 'meet', 'Esphas'
  ruby 'sample/greeter.rb', 'unfriend', 'Esphas'
  ruby 'sample/greeter.rb', 'make-friend', 'Esphas'
end
