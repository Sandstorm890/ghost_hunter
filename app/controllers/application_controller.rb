require './config/environment'

class ApplicationController < Sinatra::Base
    
    configure do
        enable :sessions
        set :session_secret, SESSION_SECRET
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get "/" do
        if logged_in?
            redirect "/user/#{session[:user_id]}"
        else
            erb :index
        end
    end

    helpers do 

        def logged_in?
            !!current_user
        end

        def current_user
            @user ||=  User.find(session[:user_id]) if session[:user_id]
        end

        def current_user?
            if session[:user_id] == params[:id]
                true
            else
                false
            end
        end  

        def sanitize_params
            params.each{|key, value| value.replace(Sanitize.clean(value))}
        end

        def render_user
            if current_user?
                "You posted this job"
            elsif @job
                "Posted by: #{@job.users[0].username}" 
            end
        end

        def render_non_user_jobs
            UserJob.all.map do |job|
                if job.user_id != session[:user_id]
                    Job.find_by(id: job.job_id)
                end
            end
            
        end

        def render_user_jobs
            UserJob.all.map do |job|
                if job.user_id == session[:user_id]
                    Job.find_by(id: job.job_id)
                end
            end
            
        end

    end
end