class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :applicant_id
      t.integer :scholarship_id
      t.integer :status

      t.timestamps
    end
  end
end
