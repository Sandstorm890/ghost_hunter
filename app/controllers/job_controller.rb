class JobController < Sinatra::Base

    configure do
        enable :sessions
        set :session_secret, "secret" # CHANGE THIS TO SOMETHING MORE SECURE
        set :public_folder, 'public'
        set :views, 'app/views/job_views'
    end
end