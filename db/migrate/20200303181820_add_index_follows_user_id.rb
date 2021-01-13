class AddIndexFollowsUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :follows, [:user_id, :follow_user_id], unique: true
  end
end
