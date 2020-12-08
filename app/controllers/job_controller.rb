require './config/environment'

class JobController < Sinatra::Base

    configure do
        enable :sessions
        set :session_secret, "secret" # CHANGE THIS TO SOMETHING MORE SECURE
        set :public_folder, 'public'
        set :views, 'app/views/job_views'
    end

    get "/jobs" do
        erb :index
    end

    get "/job/new" do
        erb :job_new
    end
    
    post "/job/new" do
        job = Job.create(params)
        UserJob.create(job_id: job.id, user_id: session[:user_id])
        redirect "/user/#{session[:user_id]}" # add jobs display in user view
    end

    delete "/job/:id" do
        @job = UserJob.find_by(job_id: params[:id])
        # binding.pry
        if Job.find(@job.job_id) && @job.user_id == session[:user_id]
            # binding.pry
            Job.find(@job.job_id).delete
            @job.delete
        end
        redirect "/user/#{session[:user_id]}"
    end

    get "/jobs/:id" do
        @job = Job.find(params[:id])
        erb :job
    end

    

    
end