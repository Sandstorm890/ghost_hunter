require './config/environment'

class UserController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret" # CHANGE THIS TO SOMETHING MORE SECURE
    set :public_folder, 'public'
    set :views, 'app/views/user_views'
  end

  get "/" do 
    erb :index
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

  post "/user/new" do 
    if User.all.map{|user| user.username}.include?(params[:username])
      erb :failure
    else
      name = Sanitize.clean(params[:name])
      age = Sanitize.clean(params[:age])
      years_experience = Sanitize.clean(params[:years_experience])
      username = Sanitize.clean(params[:username])
      password = Sanitize.clean(params[:password])
      user = User.create(name: name, age: age, years_experience: years_experience, username: username, password: password)
      session[:user_id] = user.id
      redirect "/user/#{user.id}"
    end
  end

  get "/user/:id" do
    if session[:user_id] == params[:id].to_i 
      @user = User.find(params[:id])
      erb :user
    else
      redirect "/user/#{session[:user_id]}"
    end
  end

  delete "/user/:id" do
    if session[:user_id] == params[:id].to_i
      user = Helpers.current_user(session)
      
      Job.all.each do |job|
        if job.user_ids[0] == session[:user_id]
          job.delete
        end
      end
      UserJob.all.each do |job|
        if job.user_id == user.id
          job.delete
        end
      end
      user.delete
      redirect "/"
    else
      redirect "/failure"
    end
  end
end
