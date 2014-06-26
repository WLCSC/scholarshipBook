class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :recommender_id
      t.integer :datum_id

      t.timestamps
    end
  end
end
