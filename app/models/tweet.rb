class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :retweets, class_name: "Tweet", foreign_key: "Tweet_id"
    belongs_to :tweet, class_name: "Tweet", optional: true

    def get_user_name
        self.user.name
    end

    def get_user_photo
        self.user.photo_url
    end
end
