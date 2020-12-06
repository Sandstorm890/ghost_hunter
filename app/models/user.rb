class User < ActiveRecord::Base
    has_many :jobs, through: :user_jobs
    # has many :tools, through: :jobs # thjs is causing a no method error
end