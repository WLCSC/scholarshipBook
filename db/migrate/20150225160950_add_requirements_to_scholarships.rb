class AddRequirementsToScholarships < ActiveRecord::Migration
  def change
    add_column :scholarships, :requirements, :text
  end
end
