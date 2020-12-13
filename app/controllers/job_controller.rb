require './config/environment'

class JobController < Sinatra::Base

    configure do
        enable :sessions
        set :session_secret, SESSION_SECRET
        set :public_folder, 'public'
        set :views, 'app/views/job_views'
    end

    get "/jobs" do
        erb :index
    end

    get "/jobs/:id/edit" do
        if UserJob.find_by(job_id: params[:id]).user_id == session[:user_id]
            @job = Job.find(params[:id])
            erb :job_edit
        else
            erb :"../failure"
        end
    end

    get "/jobs/new" do
        erb :job_new
    end
    
    post "/jobs" do
        location = Sanitize.clean(params[:location])
        difficulty = Sanitize.clean(params[:difficulty])
        description = Sanitize.clean(params[:description])
        job = Job.create(location: location, difficulty: difficulty, ghost_type: params[:ghost_type], date: params[:date], description: description)
        UserJob.create(job_id: job.id, user_id: session[:user_id])
        redirect "/user/#{session[:user_id]}"
    end

    patch "/jobs/:id" do 
        location = Sanitize.clean(params[:location])
        difficulty = Sanitize.clean(params[:difficulty])
        description = Sanitize.clean(params[:description])
        Job.find(params[:id]).update(location: location, difficulty: difficulty, date: params[:date], ghost_type: params[:ghost_type], description: description)
        redirect "/jobs/#{params[:id]}"
    end

    delete "/jobs/:id" do
        @job = UserJob.find_by(job_id: params[:id])
        if Job.find(@job.job_id) && @job.user_id == session[:user_id]
            Job.find(@job.job_id).delete
            @job.delete
        end
        redirect "/user/#{session[:user_id]}"
    end

    get "/jobs/:id" do
        if Job.find_by(id: params[:id])
            @job = Job.find(params[:id])
            erb :job
        else
            erb :"../failure"
        end
    end
end