class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_api_key

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :added_friends, :class_name => 'Friend', :foreign_key => 'user_id'
  has_many :followers, :class_name => 'Friend', :foreign_key => 'friend_id'

  def self.add_friends(x)
    if x
      @my_friends = Friend.where(user_id: x.id)
      friend_id_array = []
      @my_friends.each do |my_friend|
        friend_id_array << my_friend.friend_id
      end
      self.where.not(id: friend_id_array)
    end
  end

  def set_api_key
    self.api_key = generate_api_key
  end
end
