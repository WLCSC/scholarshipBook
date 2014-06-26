class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.text :value
      t.integer :field_id
      t.integer :application_id
      t.integer :status

      t.timestamps
    end
  end
end
