ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'pry'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller'
require './app/controllers/user_controller'
require_all 'app'
