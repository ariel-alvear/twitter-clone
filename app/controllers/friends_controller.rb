class FriendsController < ApplicationController
    before_action :find_user

    def create
        @friend = Friend.create(user_id: current_user.id, friend_id: params[:user_id])
        redirect_to root_path
    end

    private
    def find_user
        @user = User.find(current_user.id)
    end
end
