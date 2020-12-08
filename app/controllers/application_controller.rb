require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end



  post "/user" do
    # binding.pry
    user = User.find_by(name: params[:name])
    
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