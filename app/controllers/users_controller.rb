class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    render json: @user, serializer: UserSerializer
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    render json: { error: "User Not Found" }, status: 422 unless @user and return
  end


end
