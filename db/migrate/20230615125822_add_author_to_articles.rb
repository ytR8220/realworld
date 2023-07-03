class AddAuthorToArticles < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :user_id, :integer, null: false, foreign_key: true
  end
end
