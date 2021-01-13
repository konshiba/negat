class TweetsController < ApplicationController
  before_action :authenticate_user!
  def create
    tweet = current_user.tweets.new(tweet_params)
    tweets = Tweet.search_limited(search: params[:search])
    if tweet.save
      results = {
        flash: {
          notice: "ツイートしました",
          is_success: true,
        },
        tweets: tweets,
        tweet: Tweet.new,
      }
      render 'home/create', locals: { results: results }
    else
      results = {
        tweet: tweet,
      }
      render 'home/create', locals: { results: results }
    end
  end

  def index
    if user_signed_in?
      @user = current_user
    end
    @tweets = Tweet.search_limited(search: params[:search])
    @tweet = @user.tweets.new()
    render 'home/index'
  end

  def more
    tweets = Tweet.search_limited(
      search: params[:search],
      user_id: params[:user_id],
      offset:  params[:offset]
    )
    is_requestable = true
    if tweets.empty?
      is_requestable = false
    end
    render 'home/index', locals: {
      results: {
        tweets: tweets,
        is_requestable: is_requestable
      }
    }
  end

  def destroy
    tweet = Tweet.find(params[:id])
    unless current_user.id == tweet.user_id
      render 'tweets/destroy', locals: {
        results: {
          offset_minus: 0,
        }
      }
      return
    end
    if Tweet.find(params[:id]).destroy
      render 'tweets/destroy', locals: {
        results: {
          offset_minus: 1,
          destroyed_tweet_id: params[:id],
        }
      }
    else
      render 'tweets/destroy'
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:user_id, :content, tweet_images_images: [])
  end
end
