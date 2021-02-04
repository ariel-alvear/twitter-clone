class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :retweets, class_name: "Tweet", foreign_key: "Tweet_id"
    belongs_to :tweet, class_name: "Tweet", optional: true
end
