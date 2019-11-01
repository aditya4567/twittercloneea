class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_follow, only: :unfollow

  def follow
    @follow = Follow.new(f_user_id: params[:user_id], user_id: current_user.id)
    if @follow.save
      render json: { follow: @follow, message: "Followed successfully" }, status: 200
    else
      render json: { error: @follow.errors.full_messages }, status: 422
    end
  end

  def unfollow
    if @follow.destroy
      render json: { follow: @follow, message: "Unfollowed successfully" }, status: 200
    else
      render json: { error: @follow.errors.full_messages }, status: 422
    end
  end

  private

  def find_follow
    @follow = Follow.find_by(f_user_id: params[:user_id], user_id: current_user.id)
    unless @follow
      render json: { error: "Follow Not Found" }, status: 422
      return
    end
  end
end
