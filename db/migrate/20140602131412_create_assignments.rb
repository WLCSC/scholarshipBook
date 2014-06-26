class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :judge_id
      t.integer :scholarship_id

      t.timestamps
    end
  end
end
