class Tool < ActiveRecord::Base
    belongs_to :jobs # is nil, not empty array
end