class Datum < ActiveRecord::Base
    belongs_to :field
    belongs_to :application
    has_one :invitation
    has_many :recommenders, through: :invitations
    has_many :attachments

    def display
        case field.kind
        when 'text', 'textarea'
            value.to_s
        when 'checkbox'
            value == 'on' ? "Checked" : "Unchecked"
        when 'eca'
            '<pre>' + value.to_s.gsub("|", "\t").gsub("\n", "\n\n") + '</pre>'
        else
            value.to_s
        end.html_safe
    end

    def kind
        field.kind
    end
end
