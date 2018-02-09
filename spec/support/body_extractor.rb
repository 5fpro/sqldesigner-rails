class BodyExtractor
  def initialize(body)
    @body = body
  end

  def extract(type_name)
    send("extract_#{type_name}")
  end

  private

  def parse_body(regexp)
    @body.scan(regexp)[0][0]
  end

  def extract_body
    @body
  end

  def extract_meta_title
    parse_body(/<title>(.+)<\/title>/)
  end

  def extract_meta_desc
    (@body.scan(/<meta content="(.*?)" name="description"[^>]*>/)[0] ||
      @body.scan(/<meta name="description" content="(.*?)"[^>]*>/)[0]
    )[0]
  end

  def extract_meta_url
    parse_body(/<link href="(.+?)" rel="canonical" \/>/)
  end

  def extract_flash_message
    parse_body(/(<div class=\".*alert-.*\">.+?<\/div>)/m)
  end
end
