class AddUserToLike < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :user
    add_reference :likes, :tweet
  end
end
