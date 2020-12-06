class Jobs < ActiveRecord::Base
    has_many :users, through: :user_jobs
    has_many :tools
end