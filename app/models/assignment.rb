class Assignment < ActiveRecord::Base
    belongs_to :judge
    belongs_to :scholarship
end
