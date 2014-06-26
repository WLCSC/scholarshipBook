class Score < ActiveRecord::Base
    belongs_to :review
    belongs_to :section
end
