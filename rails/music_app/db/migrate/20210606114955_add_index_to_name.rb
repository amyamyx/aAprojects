class AddIndexToName < ActiveRecord::Migration[5.2]
  def change
    add_index :tags, [:name, :taggable_id, :taggable_type], unique: true
  end
end
