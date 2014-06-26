class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.integer :section_id
      t.string :title
      t.text :caption
      t.string :kind
      t.text :config
      t.string :completed_by

      t.timestamps
    end
  end
end
