module ApplicationHelper
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
    if content
      content = content.gsub("\u200D", "").gsub(/\P{Print}|\p{Cf}/, "")
    end
    sanitize(content, tags: %w(strong em p a b h1 h2 h3 h4 h5 h6 ul li pre code), attributes: %w(href))
  end

  def is_active controller_name
    params[:controller] == controller_name && 'active'
  end
end