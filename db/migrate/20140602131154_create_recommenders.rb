class CreateRecommenders < ActiveRecord::Migration
  def change
    create_table :recommenders do |t|
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
