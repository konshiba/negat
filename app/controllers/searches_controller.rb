class SearchesController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:search_type].blank? || params[:search_type] == 'tweets'
      @tweets = Tweet.search_limited(search: params[:search])
    elsif params[:search_type] == 'users'
      @users = User.search_limited(search: params[:search])
    end
  end
end
