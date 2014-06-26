class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
