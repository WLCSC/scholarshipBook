class AddCompleteToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :complete, :boolean
  end
end
