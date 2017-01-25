# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

require 'csv'

ActionController::Renderers.add :csv do |obj, options|
  str = obj.respond_to?(:to_csv) ? obj.to_csv : obj.to_s
  send_data str, type: Mime[:csv], disposition: "attachment"
end

Mime::Type.register "image/svg+xml", :svg
