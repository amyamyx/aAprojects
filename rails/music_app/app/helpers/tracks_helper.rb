module TracksHelper
  def track_select_helper(album_1, album_2)
    "selected".html_safe if album_1.id == album_2.id
  end
end