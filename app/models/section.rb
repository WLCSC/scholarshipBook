class Section < ActiveRecord::Base
    belongs_to :scholarship
    has_many :fields
    has_many :scores
end
