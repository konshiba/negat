class TweetImage < ApplicationRecord
  attachment :image
  belongs_to :tweet
end
