module ApplicationHelper
  def auth_token
    html = "<input type=\"hidden\" name=\"authenticiity_token\" value=\"#{form_authenticity_token}\""
    html.html_safe
  end
end
