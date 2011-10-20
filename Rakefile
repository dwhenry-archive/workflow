require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'ruby-debug'
task :default => :test
task :test => :spec

if !defined?(RSpec)
  puts "spec targets require RSpec"
else
  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    #t.pattern = 'spec/**/*_spec.rb' # not needed this is default
    t.rspec_opts = ['-cfs']
  end
end

namespace :db do
  desc 'Migrate the database'
  task :migrate => :environment do
    `sequel -m db/migrations #{DB.url}`
  end

  desc 'Rollback the database'
  task :rollback => :environment do
    migrations = DB[:schema_info]
    migration = [migrations.first[:version] - 1, 0].max
    `sequel -m db/migrations #{DB.url} -M #{migration}`
  end

  desc 'Redo the last migration'
  task :redo => [:rollback, :migrate]
end

task :environment do
  require File.join(File.dirname(__FILE__), 'lib', 'workflow')
end
