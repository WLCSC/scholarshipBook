class Invitation < ActiveRecord::Base
    belongs_to :recommender
    belongs_to :datum
end
