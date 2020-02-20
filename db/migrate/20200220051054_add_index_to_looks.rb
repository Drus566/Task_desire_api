class AddIndexToLooks < ActiveRecord::Migration[5.2]
  def change
    add_index :looks, [:user_id, :article_id], unique: true
  end
end
