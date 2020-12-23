require './config/environment'

class JobController < ApplicationController

    get "/jobs/:id/edit" do
        if logged_in? && valid_owner?
            current_job
            erb :"/job_views/job_edit"
        else
            erb :"/failure"
        end
    end

    get "/jobs/new" do
        if logged_in?
            erb :"/job_views/job_new"
        else
            erb :"/failure"
        end
    end

    get "/jobs/:id" do
        if current_job
            erb :"/job_views/job"
        else
            erb :failure
        end
    end

    post "/jobs" do
        if params[:location] == ""
            erb :job_create_failure
        else
            clean_params = sanitize_params # is this more efficient than calling 'sanitize_params' a bunch in the arguments?
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
        if valid_owner?
            @job.destroy
        else
            erb :failure
        end
        redirect "/user/#{session[:user_id]}"
    end

    private
    def valid_owner?
        if current_user_job.user_id == session[:user_id]
            true
        else
            false
        end
    end

    def current_job
        @job = Job.find_by(id: params[:id])
    end

    def current_user_job
        @current_user_job = UserJob.find_by(job_id: current_job.id)
    end

end