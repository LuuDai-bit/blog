module BreadcrumbsHelper
  def register_breadcrumbs(*sites)
    html = %Q(
      <span class="bread-root-item">
        <a href="#{admin_root_path}">Home</a>
      </span>
    )

    sites.each do |site|
      html += %Q(
        <span class="bread-element-item">
          <a href=#{site[:url]}>#{site[:name]}</a>
        </span>
      )
    end

    html.html_safe
  end
end
