class AddNotesToScholarships < ActiveRecord::Migration
  def change
    add_column :scholarships, :notes, :string
  end
end
