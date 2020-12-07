require './config/environment'

class UserController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/user/new" do
    erb :user_new
  end

  post "/user" do

  end

end
