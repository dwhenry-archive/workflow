require File.join(File.dirname(__FILE__), 'environment.rb')
require 'rubygems'
require 'bundler/setup'
require 'rake'

task :default => [:test, :features]
task :test => :spec

begin
  require 'rspec/core/rake_task'

  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    #t.pattern = 'spec/**/*_spec.rb' # not needed this is default
    t.rspec_opts = ['-cfs']
  end
rescue LoadError
  desc "Rspec rake task not available"
  task :spec do
    abort 'Spec rake task is not available. Be sure to install spec as a gem or plugin'
  end
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
  end
  
  Cucumber::Rake::Task.new(:'cucumber:wip') do |t|
    t.cucumber_opts = "--tags @wip --format pretty"
  end
  
  task :features => :'db:test:prepare'
  task :'features:wip' => :'db:test:prepare'
  
  task :cucumber => :features
  task :'cucumber:wip' => :'features:wip'
  
rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
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
  
  desc 'Redo all the migration'
  task :restart => :environment do
    `sequel -m db/migrations #{DB.url} -M 0`
    `sequel -m db/migrations #{DB.url}`
  end
  
  namespace :test do
    task :prepare do
      print "\nDumping Database Schema (#{Db.name('development')})..\n"
      `pg_dump -h localhost --format=t #{Db.name('development')} > db/schema.sql`
      print "Restoring Database Schema (#{Db.name('test')})..\n\n"
      `pg_restore -c -s -h localhost -d #{Db.name('test')} db/schema.sql`
    end
  end
end

task :environment do
  require File.join(File.dirname(__FILE__), 'lib', 'workflow')
end
