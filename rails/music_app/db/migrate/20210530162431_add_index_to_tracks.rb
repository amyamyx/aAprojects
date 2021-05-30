class AddIndexToTracks < ActiveRecord::Migration[5.2]
  def change
    add_index :tracks, [:album_id, :ord], unique: true
    remove_index :tracks, [:album_id, :title]
  end
end
