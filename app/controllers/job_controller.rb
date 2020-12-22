require './config/environment'

class JobController < ApplicationController

    get "/jobs/:id/edit" do
        if UserJob.find_by(job_id: params[:id]).user_id == session[:user_id]
            @job = Job.find(params[:id])
            erb :"/job_views/job_edit"
        else
            erb :"../failure"
        end
    end

    get "/jobs/new" do
        # check if logged in
        erb :"/job_views/job_new"
    end
    
    post "/jobs" do
        if params[:location] == ""
            erb :job_create_failure
        else
            clean_params = sanitize_params
            job = Job.create(location: clean_params[:location], difficulty: clean_params[:difficulty], ghost_type: params[:ghost_type], date: params[:date], description: clean_params[:description])
            UserJob.create(job_id: job.id, user_id: session[:user_id])
            redirect "/user/#{session[:user_id]}"
        end
    end

    patch "/jobs/:id" do 
        clean_params = sanitize_params
        current_job.update(location: clean_params[:location], difficulty: clean_params[:difficulty], date: params[:date], ghost_type: params[:ghost_type], description: clean_params[:description])
        redirect "/jobs/#{params[:id]}"
    end

    delete "/jobs/:id" do
        @user_job = UserJob.find_by(job_id: params[:id])
        @job = @user_job.job
        if valid_owner?
            @job.destroy
        else
            redirect :"../failure"
        end
        redirect "/user/#{session[:user_id]}"
    end

    get "/jobs/:id" do
        if Job.find_by(id: params[:id])
            @job = Job.find(params[:id])
            erb :"/job_views/job"
        else
            erb :"../failure"
        end
    end

    private
    def valid_owner?
        if @job && current_user_job.user_id == session[:user_id]
            true
        else
            false
        end
    end

    def current_job
        Job.find(params[:id])
    end

    def current_user_job
        UserJob.find_by(job_id: params[:id])
    end

end