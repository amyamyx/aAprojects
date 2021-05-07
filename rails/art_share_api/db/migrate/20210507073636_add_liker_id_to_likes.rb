class AddLikerIdToLikes < ActiveRecord::Migration[5.2]
  def change
      add_column :likes, :liker_id, :integer, null: false
      add_index :likes, [:liker_id, :likable_id, :likable_type], unique: true
  end
end
