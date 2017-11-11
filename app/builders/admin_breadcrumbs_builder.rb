# ref: https://github.com/weppos/breadcrumbs_on_rails/blob/master/lib/breadcrumbs_on_rails/breadcrumbs.rb#L72
class AdminBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:ol, class: 'breadcrumb') do
      @elements.collect do |element|
        render_element(element)
      end.join('').html_safe
    end
  end

  private

  def render_element(element)
    last = element == @elements.last
    @context.content_tag(:li, class: "breadcrumb-item #{'active' if last}") do
      if element.path.nil? || last
        compute_name(element)
      else
        @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      end
    end
  end
end
