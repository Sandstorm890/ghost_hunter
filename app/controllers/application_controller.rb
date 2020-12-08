require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret" # CHANGE THIS TO SOMETHING MORE SECURE
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end
  
end