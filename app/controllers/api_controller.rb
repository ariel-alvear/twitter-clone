class ApiController < ApplicationController
    before_action :set_tweet, only: %i[ show edit update destroy ]
    skip_before_action :verify_authenticity_token

    def index
        @tweets = Tweet.all.order("created_at DESC").limit(50)

        render json: @tweets
    end

    def between_dates
        first_date = params[:date1]
        last_date = params[:date2]
        @tweets = Tweet.where(:created_at => first_date..last_date)
        render json: @tweets
    end

    # POST /api/create
    def create
        @tweet = Tweet.new(tweet_params)

        if @tweet.save
            render json: @tweet, status: :created, location: @tweet
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
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