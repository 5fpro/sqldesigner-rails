module MetaTagHelper
  def set_meta(data = {})
    data.deep_symbolize_keys!
    default_data = default_meta
    url = data.delete(:url) || data.delete(:canonical)
    image = append_og_image_protocol(data.delete(:image) || data.delete(:image_src))
    data.select! { |_k, v| v.present? }
    default_data[:canonical] = url || default_data[:canonical]
    default_data[:image_src] = image || default_data[:image_src]
    default_data[:og][:image] = image || default_data[:og][:image]
    set_meta_tags(default_data.deep_merge(data))
  end

  def default_meta
    data = SeoSetting.defaults.to_h.deep_symbolize_keys
    data[:og].merge!(
      title: :title,
      site_name: :site,
      description: :description
    )
    data[:canonical] = url_for(request.params.merge(host: Setting.host))
    data[:image_src] = data[:og][:image][:url] = default_og_image_url
    data[:revision] = Revision.to_h unless Rails.env.production?
    data
  end

  def default_og_image_url
    append_og_image_protocol(SeoSetting.defaults.og.image.url)
  end

  def append_og_image_protocol(url)
    return if url.blank?
    return "#{Setting.default_protocol}:#{url}" if url[0, 2] == '//'
    url
  end
end
