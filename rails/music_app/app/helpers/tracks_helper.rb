module TracksHelper
  def track_select_helper(album_1, album_2)
    "selected".html_safe if album_1.id == album_2.id
  end

  def ugly_lyrics(lyrics)
    formatted_lyrics =""
    lyrics.lines.each do |line|
      formatted_lyrics += "&#9835; #{ h(line) }"
    end

    "<pre class=\"lyrics\">#{ formatted_lyrics }</pre>".html_safe
  end
end