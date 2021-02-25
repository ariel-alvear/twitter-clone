ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :photo_url
  #
  # or
  #
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :photo_url
    column :following do |user|
      user.added_friends.count
    end
    column :tweets do |user|
      user.tweets.count
    end
    column :likes_given do |user|
      user.likes.count
    end
    column :retweets do |user|
      user.tweets.where.not(tweet_id: nil).count
    end
  end
  
end
