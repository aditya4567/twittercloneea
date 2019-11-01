class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: :user_tweets

  def feeds
    @tweets = Tweet.where(user: current_user.followings).order( "tweets.created_at #{params[:order] || 'ASC'}" )

    render json: @tweets, each_serializer: TweetSerializer
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      render json: { tweet: @tweet, message: "Tweet created successfully" }, status: 200
    else
      render json: { error: @tweet.errors.full_messages }, status: 422
    end
  end

  def user_tweets
    render json: { tweets: @user.tweets }, status: 200
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
    render json: { error: "User Not Found" }, status: 422 unless @user and return
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end


end
