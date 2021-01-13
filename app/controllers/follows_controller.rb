class FollowsController < ApplicationController
  before_action :authenticate_user!
  def create
    follow_user_id = params[:follow_user_id].to_i
    if current_user.id == follow_user_id
      # MAYBE: エラーメッセージの確認
      flash[:notice] = '自身をフォローすることはできません'
    else
      follow = current_user.follows.new(follow_params)
      follow.save
    end
    @user = User.find(follow_user_id)
  end

  def destroy
    follow_user_id = params[:id].to_i
    Follow.find_by(follow_user_id: follow_user_id, user_id: current_user.id).destroy
    @user = User.find(follow_user_id)
  end

  private
  def follow_params
    params.permit(:user_id, :follow_user_id)
  end
end