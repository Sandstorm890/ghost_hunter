require './config/environment'

class UserController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret" # CHANGE THIS TO SOMETHING MORE SECURE
    set :public_folder, 'public'
    set :views, 'app/views/user_views'
  end

  post "/user" do
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
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
