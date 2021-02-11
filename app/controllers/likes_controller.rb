class LikesController < ApplicationController
    before_action :find_like, only: [:destroy]
    before_action :find_tweet

    def create
        if user_signed_in?
            if already_liked?
                flash[:notice] = "You can't like more than once"
            else
                @tweet.likes.create(user_id: current_user.id)
            end
            redirect_to root_path
        else
            redirect_to new_user_session_path
        end
    end

    def destroy
        if !(already_liked?)
            flash[:notice] = "Cannot unlike"
        else
            @like.destroy
        end
        redirect_to root_path
    end

    private
    def find_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

    def find_like
        @tweet = Tweet.find(params[:tweet_id])
        @like = @tweet.likes.find(params[:id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
    end
end
