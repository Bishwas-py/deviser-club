module ApplicationHelper
  include Pagy::Frontend

  def clean_links html
    html.gsub!(/\<a href=["'](.*?)["']\>(.*?)\<\/a\>/mi, '<a href="\1?source=deviser_club.com" class="link" rel="nofollow">\2</a>')
    html.html_safe
  end

  def dom_id_for_records(*records)
    records.map do |record|
      dom_id(record)
    end.join "_"
  end

  def purify content
    content = content.strip
    sanitize(content, tags: %w(strong em p a b h1 h2 h3 h4 h5 h6 ul ol li pre code img blockquote), attributes: %w(href src alt))
  end

  def is_active(controller_name, action_name)
    (params[:controller] == controller_name && params[:action] == action_name) && 'active'
  end
end