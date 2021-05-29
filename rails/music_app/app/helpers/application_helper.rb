module ApplicationHelper
  def auth_token
    html = "<input type=\"hidden\" "
    html += "name=\"authenticity_token\" "
    html += "value=\"#{ form_authenticity_token }\" >"

    html.html_safe
  end

  def error_messages(errors)
    return if errors.nil? || errors.empty?

    html = ""
    errors.each do |error|
      html += "<p>- #{ h(error) }</p> <br>"
    end

    html.html_safe
  end

  def delete_hidden_input
    html = "<input type=\"hidden\" "
    html += "name=\"_method\" value=\"DELETE\">"

    html.html_safe
  end

  def patch_hidden_input
    html = "<input type=\"hidden\" "
    html += "name=\"_method\" value=\"PATCH\">"

    html.html_safe
  end
end
