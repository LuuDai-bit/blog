require "rails_helper"

RSpec.describe BreadcrumbsHelper, type: :helper do
  describe "register_breadcrumbs" do
    before do
      allow(helper).to receive(:admin_root_path).and_return("/admin")
    end

    it "renders the home breadcrumb" do
      html = helper.register_breadcrumbs

      expect(html).to include('<a href="/admin">Home</a>')
      expect(html).to include('class="bread-root-item"')
      expect(html).to be_html_safe
    end

    it "renders one additional breadcrumb site" do
      html = helper.register_breadcrumbs({ url: "/admin/posts", name: "Posts" })

      expect(html).to include('<a href=/admin/posts>Posts</a>')
      expect(html.scan('class="bread-element-item"').size).to eq(1)
    end

    it "renders multiple breadcrumb items in order" do
      html = helper.register_breadcrumbs(
        { url: "/admin/posts", name: "Posts" },
        { url: "/admin/posts/1/edit", name: "Edit" }
      )

      expect(html).to include('<a href=/admin/posts>Posts</a>')
      expect(html).to include('<a href=/admin/posts/1/edit>Edit</a>')
      expect(html.scan('class="bread-element-item"').size).to eq(2)
    end
  end
end