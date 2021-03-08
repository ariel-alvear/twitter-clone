class AddApiKeyToUser < ActiveRecord::Migration[6.1]
  include ApplicationHelper

  def up
    add_column :users, :api_key, :string

    User.find_each do |user|
      api_key = generate_api_key
      user.update_columns(api_key: api_key)
    end

    change_column :users, :api_key, :string, 
      unique: true, null: false

    add_index :users, :api_key, unique: true
  end

  def down
    remove_column :users, :api_key
  end
end
