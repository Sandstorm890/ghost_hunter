ENV['SINATRA_ENV'] ||= "development"
SESSION_SECRET = "21c2a6478ef1ca54440df77f24d2011acb9b28af9fe23d64d28bf5b264f911c3a1f1e7a39328d0629f238f4ef09416800f62de767a5422092aa20adfa2ca35f9" 
require 'bundler/setup'
require 'pry'
require 'sanitize'
require 'securerandom'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller.rb'
require './app/controllers/user_controller'
require './app/helpers/helpers.rb'

require_all 'app'
