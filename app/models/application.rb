class Application < ActiveRecord::Base
    belongs_to :applicant
    belongs_to :scholarship
    has_many :data
    has_many :reviews
    has_many :scores, through: :reviews
    before_save :verify_status

    def sections
        scholarship.sections
    end

    def verify_status
        if scholarship.require_third_party?
            if status == 100
                if third_party_data.where('status < 100').count > 0
                    self.status = 180
                end
            elsif status == 180
                if third_party_data.where('status < 100').count == 0
                    self.status = 100
                end
            end
        end
    end

    def third_party_data
        data.where(:field_id => scholarship.third_party_fields)
    end

    def first_party_data
        data.where(:field_id => scholarship.first_party_fields)
    end
end
