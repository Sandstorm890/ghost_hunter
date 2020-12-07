require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get "/user/new" do
      erb :user_new
  end

  get "/user/:id" do
    @user = User.find(params[:id])
    erb :user
  end

  post "/user/new" do 
    @user = User.create(params)
    erb :user
  end

  delete "/user/:id" do
    user = User.find(params[:id])
    user.delete
    redirect "/"
  end

end