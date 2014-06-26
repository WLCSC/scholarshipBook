class Applicant < ActiveRecord::Base
    belongs_to :user
    has_many :applications
    has_many :scholarships, through: :applications

    def name
        user.name
    end
end
