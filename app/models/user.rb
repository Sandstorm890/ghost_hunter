class User < ActiveRecord::Base
    has_secure_password
    has_many :user_jobs
    has_many :jobs, through: :user_jobs
    # has many :tools, through: :user_jobs # this is causing a no method error
end