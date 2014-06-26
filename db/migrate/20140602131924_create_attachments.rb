class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :title
      t.integer :datum_id

      t.timestamps
    end
  end
end
