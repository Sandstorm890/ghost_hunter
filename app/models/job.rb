class Job < ActiveRecord::Base
    has_many :user_jobs, dependent: :destroy
    has_many :users, through: :user_jobs
end