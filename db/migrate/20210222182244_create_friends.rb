class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.references :user, null: false
      t.references :friend, null: false

      t.timestamps
    end
  end
end
