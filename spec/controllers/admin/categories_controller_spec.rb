require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }

  before { sign_in user }

  describe "GET #index" do
    subject { get :index, params: { page: 1, per_page: 20 } }

    it "should return list of categories" do
      subject

      categories = assigns(:categories)
      expect(categories.pluck(:id)).to eq [category.id]
    end
  end

  describe "GET #edit" do
    subject { get :edit, params: { id: category.id } }

    it "should render the edit template" do
      expect(subject).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    subject { patch :update, params: { id: category.id, category: { highlighted: true, highlight_order: 1 } } }

    it "should update the category and redirect" do
      subject
      expect(category.reload.highlighted).to be true
      expect(category.reload.highlight_order).to eq(1)
      expect(response).to redirect_to(admin_categories_path)
    end

    context "with invalid params" do
      subject { patch :update, params: { id: category.id, category: { highlight_order: 10 } } }
      
      it "should not update order > 5" do
        subject
        expect(category.reload.highlight_order).not_to eq(10)
        expect(response).to render_template(:edit)
      end
    end
  end
end
