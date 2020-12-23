require './config/environment'

class ApplicationController < Sinatra::Base
    
    configure do
        enable :sessions
        set :session_secret, SESSION_SECRET
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get "/" do
        if params[:user_id]
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

        def render_user_name
            if current_user?
                "You posted this job"
            elsif @job
                "Posted by: #{@job.users[0].username}" 
            end
        end

        def render_non_user_jobs
            jobs = []
            UserJob.all.each do |job|
                if job.user_id != session[:user_id]
                    jobs << Job.find_by(id: job.job_id)
                end
            end
            if jobs == []
                "No current jobs"
            else
                jobs
            end
            
        end

        def render_user_jobs
            jobs = []
            UserJob.all.map do |job|
                if job.user_id == session[:user_id]
                    jobs << Job.find_by(id: job.job_id)
                end
            end
            if jobs == []
                "No current jobs"
            else
                jobs
            end
            
        end

    end
end