class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :likes
  
  has_many :added_friends, :class_name => 'Friend', :foreign_key => 'user_id'
  has_many :followers, :class_name => 'Friend', :foreign_key => 'friend_id'
end
