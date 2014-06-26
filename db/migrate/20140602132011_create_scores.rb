class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score
      t.text :notes
      t.integer :review_id
      t.integer :section_id
      t.integer :status

      t.timestamps
    end
  end
end
