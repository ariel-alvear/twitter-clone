class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :retweets, class_name: "Tweet", foreign_key: "tweet_id"
    belongs_to :parent_tweet, class_name: "Tweet", optional: true

    validates :content, presence: true

    def get_user_name
        self.user.name
    end

    def get_user_photo
        self.user.photo_url
    end

    def get_like_photo
        self.likes.user_id.photo_url
    end
end
