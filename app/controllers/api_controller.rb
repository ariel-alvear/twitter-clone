class ApiController < ApplicationController
    before_action :set_tweet, only: %i[ show edit update destroy ]

    def index
        @tweets = Tweet.all

        render json: @tweets
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
        @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
        params.require(:tweet).permit(:content, :user_id, :tweet_id)
    end
end