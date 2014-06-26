class Field < ActiveRecord::Base
    belongs_to :section
    has_many :data
end
