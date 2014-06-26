class Scholarship < ActiveRecord::Base
    has_many :assignments
    has_many :judges, through: :assignments
    has_many :applications
    has_many :applicants, through: :applications
    has_many :reviews, through: :applications
    has_many :sections
    has_many :fields, through: :sections

    def require_third_party?
        fields.where.not(:completed_by => 'applicant').count > 0
    end

    def third_party_fields
        fields.where.not(:completed_by => 'applicant')
    end

    def admin_fields
        fields.where(:completed_by => 'admin')
    end

    def require_admin?
        admin_fields.count > 0
    end

    def first_party_fields
        fields.where(:completed_by => 'applicant')
    end

    def require_first_party?
        fields.where(:completed_by => 'applicant').count > 0
    end

    def display
        title
    end
end

