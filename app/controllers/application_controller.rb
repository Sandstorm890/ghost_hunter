require './config/environment'

class ApplicationController < Sinatra::Base
    
    configure do
        enable :sessions
        set :session_secret, SESSION_SECRET
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get "/" do
        erb :index
    end

    helpers do 

        def logged_in?
            !!current_user
        end

        def current_user
            @user ||=  User.find(session[:user_id]) if session[:user_id]
        end

        def sanitize_params
            params.each{|key, value| value.replace(Sanitize.clean(value))}
        end

        def user_job(id)
            @user_job = UserJob.find_by(job_id: id)
        end

    end
end