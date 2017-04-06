require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :console do
  exec "irb -r zoom_search_s4m -I ./lib"
end

