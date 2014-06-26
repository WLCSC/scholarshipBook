class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.text :caption
      t.text :review_comments
      t.integer :scholarship_id

      t.timestamps
    end
  end
end
