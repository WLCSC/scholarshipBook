class Applicant < ActiveRecord::Base
    belongs_to :user
    has_many :applications
    has_many :scholarships, through: :applications

    def name
        begin 
            user.name 
        rescue
            id.to_s
        end
    end
end
