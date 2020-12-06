class User < ActiveRecord::Base
    has_many :users_jobs
    has_many :jobs, through: :users_jobs
    # has many :tools, through: :jobs # thjs is causing a no method error
end