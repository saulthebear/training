module ApplicationHelper
  def form_authenticity
    html = '<input type="hidden" name="authenticity_token"'
    html += "value=\"#{form_authenticity_token}\""
    html += '>'
    html.html_safe
  end
end
