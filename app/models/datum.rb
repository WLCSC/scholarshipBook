class Datum < ActiveRecord::Base
    belongs_to :field
    belongs_to :application
    has_one :invitation
    has_many :recommenders, through: :invitations
    has_many :attachments

    def display
        case field.kind
        when 'text', 'textarea'
            value
        else
            value
        end
    end
end
