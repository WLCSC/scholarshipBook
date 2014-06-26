class CreateScholarships < ActiveRecord::Migration
  def change
    create_table :scholarships do |t|
      t.string :title
      t.text :caption
      t.boolean :global
      t.boolean :active

      t.timestamps
    end
  end
end
