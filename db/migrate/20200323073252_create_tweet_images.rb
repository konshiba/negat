class CreateTweetImages < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_images do |t|
      t.integer :tweet_id
      t.string :image_id

      t.timestamps
    end
  end
end
