class Friend < ApplicationRecord
  belongs_to :user_id
  belongs_to :friend_id
end
