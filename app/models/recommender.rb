class Recommender < ActiveRecord::Base
    belongs_to :user
    has_many :invitations
    has_many :data, through: :invitations

    def name
        user.name
    end
end
