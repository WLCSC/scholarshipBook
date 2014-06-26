class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :notes
      t.integer :judge_id
      t.integer :application_id
      t.integer :status

      t.timestamps
    end
  end
end
