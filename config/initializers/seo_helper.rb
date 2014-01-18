# -*- encoding : utf-8 -*-
SeoHelper.configure do |config|
  config.skip_blank               = false
  config.site_name = "SQL Designer"
  config.default_page_description = ""
  config.default_page_keywords    = ""
  config.default_page_image = ""
  config.site_name_formatter  = lambda { |title, site_name|   "#{title} « #{site_name}".html_safe }
  config.pagination_formatter = lambda { |title, page_number| "#{title} - Page No.#{page_number}" }

end
