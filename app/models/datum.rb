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
        when 'checkbox'
            value == 'on' ? "Checked" : "Unchecked"
        else
            value
        end
    end
end
