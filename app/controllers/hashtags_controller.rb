class HashtagsController < ApplicationController
    def index
        @hashtags = Tweet.all_hashtags
    end
end