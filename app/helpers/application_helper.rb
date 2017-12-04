module ApplicationHelper

  # after jQuery loaded
  def load_redactor2_js
    javascript_include_tag '//assets-5fpro-com.s3.amazonaws.com/vendors/redactor2/redactor2.min.js'
  end

  def load_redactor2_css
    stylesheet_link_tag '//assets-5fpro-com.s3.amazonaws.com/vendors/redactor2/redactor2.min.css'
  end
end
