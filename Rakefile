require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task tests: [:spec]

desc 'Run the specs.'
RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_test.rb'
  task.verbose = false
end
