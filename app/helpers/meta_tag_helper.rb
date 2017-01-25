module MetaTagHelper
  def set_meta(data = {})
    url = data[:url] || url_for(request.params.merge(host: Setting.host))
    data[:title] ||= default_meta[:title]
    data[:description] ||= default_meta[:description]
    data[:keywords] ||= default_meta[:keywords]
    data[:site] ||= default_meta[:site]
    data[:og] = {
      title:       (data[:title] || data[:site]),
      description: data[:description],
      url:         url,
      type:        data[:og_type] || default_meta[:og_type]
    }
    data[:fb] = {
      app_id: default_meta[:fb_app_id],
      admins: default_meta[:fb_admin_ids]
    }
    data[:og][:image] = data[:image] if data[:image]
    set_meta_tags(data.merge(
                    reverse:   default_meta[:reverse],
                    separator: default_meta[:separator],
                    canonical: url
    ))
  end

  def default_meta
    h = SeoSettings.defaults
    h[:icon] ||= [
      { href: ActionController::Base.helpers.asset_path('fav-icon.png'), type: 'image/png' },
      { href: ActionController::Base.helpers.asset_path('fav-icon.png'), type: 'image/png', rel: 'apple-touch-icon apple-touch-icon-precomposed' }
    ]
    h
  end
end
