class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
    end
    @tweets = Tweet.search_limited
    @tweet = Tweet.new
    @tweet.tweet_images.build
  end
end
