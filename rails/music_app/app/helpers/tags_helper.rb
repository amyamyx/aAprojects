module TagsHelper
  def taggable_li(taggable)
    link_url = nil

    case taggable.class.to_s
    when "Band"
      link_url = band_url(taggable)
    when "Album"
      link_url = album_url(taggable)
    when "Track"
      link_url = track_url(taggble)
    end

    html = "<a href=\"#{ link_url }\">"
    html += taggable.class.to_s
    html += ": #{ h(taggable.try(:name) || taggable.title) }"
    html += "</a>"

    html.html_safe
  end
end