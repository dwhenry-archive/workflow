require 'sequel'

RACK_ENV = (ENV['RACK_ENV'] ||= 'development')

if RACK_ENV == 'development'
  require 'ruby-debug'
end
module Db
  class << self
    def name(env=RACK_ENV)
      "workflow_#{env}"
    end
  end
end

DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost/#{Db.name}")
