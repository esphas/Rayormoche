require 'rake'

task :default => :sample

task :sample => :output

Dir['sample/**/*.rake'].each{|f| import f}
