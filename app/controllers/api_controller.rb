class ApiController < ApplicationController

    def news
        @tweets = Tweet.all

        render json: @tweets
    end
end