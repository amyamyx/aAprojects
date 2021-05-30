module AlbumsHelper
  def select_helper(band_1, band_2)
    html = ""
    html += "selected" if band_1.id == band_2.id
    html.html_safe
  end
end