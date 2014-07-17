require "bundler/gem_tasks"
require "rake/testtask"
require "warbler"

task default: "test"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/*_test.rb"
end

Warbler::Task.new
