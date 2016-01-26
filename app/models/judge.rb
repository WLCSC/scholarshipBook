class Judge < ActiveRecord::Base
    belongs_to :user
    has_many :reviews
    has_many :assignments
    has_many :scholarships, through: :assignments

    def name
        user ? user.name : id
    end
end
