class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string          #追加
    add_column :users, :profile_image, :string #追加
    add_column :users, :introduction, :string  #追加
  end
end
