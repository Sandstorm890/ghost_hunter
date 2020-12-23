require './config/environment'

class UserController < ApplicationController

  get "/user/new" do
    erb :"/user_views/user_new"
  end

  get "/user/:id" do
    if logged_in? && valid_user? 
      current_user
      erb :"/user_views/user"
    else
      erb :failure
    end
  end

  post "/user/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/user/#{user.id}"
    else
      redirect "/user/new"
    end
  end

  post "/user/new" do 
    if params.each.any?{|key, value| value == ""}
      erb :"/user_views/user_create_failure"
    elsif User.find_by(username: Sanitize.clean(params[:username]).lstrip.chop)
      erb :"/user_views/username_taken"
    else
      clean_params = sanitize_params
      user = User.create(name: clean_params[:name], age: clean_params[:age], years_experience: clean_params[:years_experience], username: clean_params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect "/user/#{user.id}"
    end
  end

  post "/user/logout" do
    session.delete(:user_id)
    redirect "/"
  end

  delete "/user/:id" do
    if valid_user?
      current_user
      Job.all.each do |job|
        if job.user_ids[0] == session[:user_id]
          job.destroy
        end
      end
      @user.destroy
      session.delete(:user_id)
      redirect "/"
    else
      erb :failure
    end
  end

  private
  def valid_user?
    if session[:user_id] == params[:id].to_i
      true
    else
      false
    end
  end

end
