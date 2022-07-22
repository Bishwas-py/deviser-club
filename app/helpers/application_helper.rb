module ApplicationHelper
  def clean_links html
    html.gsub!(/\<a href=["'](.*?)["']\>(.*?)\<\/a\>/mi, '<a href="\1?source=deviser_club.com" class="link" rel="nofollow">\2</a>')
    html.html_safe
  end

  def is_same_ip(post_ip, r:request)
    r.remote_ip == post_ip
  end

  def dom_id_for_records(*records)
    records.map do |record|
      dom_id(record)
    end.join "_"
  end
end