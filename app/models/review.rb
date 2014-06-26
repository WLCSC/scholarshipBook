class Review < ActiveRecord::Base
    belongs_to :judge
    belongs_to :application
    has_many :scores
end
