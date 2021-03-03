class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets or /tweets.json
  def index
    if user_signed_in?
      @tweets = Tweet.tweets_for_me(current_user).page(params[:page]).order("created_at DESC")
      @users = User.add_friends(current_user)
    else
      @tweets = Tweet.all.page(params[:page]).order("created_at DESC")
    end
    @tweet = Tweet.new

    @@retweet = 0
    
    if params[:tweetsearch].present?
      @tweets = Tweet.search_my_tweets(params[:tweetsearch]).page(params[:page]).order("created_at DESC")
    end

    if params[:hashtag].present?
      @tweets = Tweet.search_my_tweets("##{params[:hashtag]}").page(params[:page]).order("created_at DESC")
    end
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    if user_signed_in?
      @tweet = Tweet.new
    else
      redirect_to new_user_session_path
    end
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.tweet_id = @@retweet
    

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Has creado un tweet!" }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def retweet
    @tweet = Tweet.new
    @@retweet = params[:id]
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