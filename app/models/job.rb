class Job < ActiveRecord::Base
    has_many :users, through: :users_jobs
    has_many :tools
end