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

  post "/user" do
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # binding.pry
      redirect "/user/#{user.id}"
    else
      redirect "/user/new"
    end
  end

  get "/user/new" do
      erb :user_new
  end

  post "/user/logout" do
    session.clear
    redirect "/"
  end

  get "/user/:id" do
    # binding.pry
    if session[:user_id] == params[:id].to_i 
      @user = User.find(params[:id])
      erb :user
    else
      redirect "/user/#{session[:user_id]}"
    end
  end

  post "/user/new" do 
    user = User.create(params)
    redirect "/user/#{user.id}"
  end

  delete "/user/:id" do
    user = User.find(params[:id])
    user.delete
    redirect "/"
  end

end