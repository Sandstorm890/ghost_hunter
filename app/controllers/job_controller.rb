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

    get "/jobs/:id/edit" do
        @job = Job.find(params[:id])
        erb :job_edit
    end

    get "/job/new" do
        erb :job_new
    end
    
    post "/job" do
        job = Job.create(params)
        UserJob.create(job_id: job.id, user_id: session[:user_id])
        redirect "/user/#{session[:user_id]}"
    end

    patch "/job/:id" do 
        Job.find(params[:id]).update(location: params[:location], difficulty: params[:difficulty], date: params[:date], ghost_type: params[:ghost_type], description: params[:description] )
        redirect "/jobs/#{params[:id]}"
    end

    delete "/job/:id" do
        @job = UserJob.find_by(job_id: params[:id])
        if Job.find(@job.job_id) && @job.user_id == session[:user_id]
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