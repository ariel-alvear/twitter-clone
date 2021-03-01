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

    def self.tweets_for_me(x)
        @my_friends = Friend.where(user_id: x.id)
        friend_id_array = []
        @my_friends.each do |my_friend|
            friend_id_array << my_friend.friend_id
        end
        self.where(user_id: friend_id_array).or(self.where(user_id: x.id))
    end

    def self.search_my_tweets(x)
        @my_tweets = Tweet.all
        my_tweet_id_array = []
        @my_tweets.each do |my_tweet|
            if my_tweet.content.include? "#{x}"
                my_tweet_id_array << my_tweet.id
            end
        end
        self.where(id: my_tweet_id_array)
    end
end
