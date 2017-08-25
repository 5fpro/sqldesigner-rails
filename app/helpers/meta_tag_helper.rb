module MetaTagHelper
  def set_meta(data = {})
    url = data[:url] || url_for(request.params.merge(host: Setting.host))
    data[:title] ||= default_meta.title
    data[:description] ||= default_meta.description
    data[:keywords] ||= default_meta.keywords
    data[:site] ||= default_meta.site
    data[:og] = {
      title:       (data[:title] || data[:site]),
      description: data[:description],
      url:         url,
      type:        data[:og_type] || default_meta.og.type
    }
    data[:fb] = {
      app_id: default_meta.fb.app_id,
      admins: default_meta.fb.admin_ids
    }
    data[:og][:image] = append_og_image_protocol(data[:image] || default_og_image)
    data[:nofollow] = true if data[:nofollow] == true
    data[:noindex] = true if data[:noindex] == true

    set_meta_tags(data.merge(
                    reverse:   default_meta.reverse,
                    separator: default_meta.separator,
                    canonical: url
    ))
  end

  def default_meta
    SeoSetting.defaults
  end

  def default_og_image
    default_meta.og.image
  end

  def append_og_image_protocol(image)
    url = image.is_a?(Hash) ? image.symbolize_keys[:url] : image
    if url[0, 2] == '//'
      url = "#{Setting.default_protocol}:#{url}"
      return image.symbolize_keys.merge(url: url) if image.is_a?(Hash)
      return url
    end
    image
  end
end
