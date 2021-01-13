class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: params[:id]).order(id: :DESC).limit(20)
    @follow = Follow.where(user_id: current_user.id, follow_user_id: params[:id])
  end

  def edit
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id])
    else
      redirect_to user_path(params[:id], user_id: params[:id].to_i)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "保存しました"
      redirect_to user_path(params[:id], user_id: params[:id].to_i)
    else
      flash.now[:notice] = "保存に失敗しました"
      render 'users/edit'
    end
  end

  def more
    users = User.search_limited(search: params[:search], offset:  params[:offset])
    is_requestable = true
    if users.empty?
      is_requestable = false
    end
    render 'users/index', locals: {
      results: {
        users: users,
        is_requestable: is_requestable
      }
    }
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :introduction, :profile_image)
  end
end
