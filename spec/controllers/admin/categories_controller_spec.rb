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
end
