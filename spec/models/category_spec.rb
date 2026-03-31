# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:post_categories).dependent(:destroy) }
    it { should have_many(:posts).through(:post_categories) }
  end

  describe 'validations' do
    subject { create(:category) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:highlight_order).is_greater_than(0).is_less_than_or_equal_to(5).allow_nil }
  end

  describe 'callbacks and custom validations' do
    describe '#maximum_highlighted_categories' do
      it 'does not allow more than 5 highlighted categories' do
        5.times { |i| create(:category, name: "Cat_#{i}", highlighted: true, highlight_order: i + 1) }
        category = build(:category, name: 'Extra Cat', highlighted: true, highlight_order: 1)
        expect(category).not_to be_valid
        expect(category.errors[:highlighted]).to include("can't highlight more than 5 categories")
      end

      it 'allows exactly 5 highlighted categories' do
        4.times { |i| create(:category, name: "Cat_#{i}", highlighted: true, highlight_order: i + 1) }
        category = build(:category, name: 'Extra Cat', highlighted: true, highlight_order: 5)
        expect(category).to be_valid
      end
    end

    describe '#adjust_highlight_order' do
      let!(:cat1) { create(:category, highlighted: true, highlight_order: 1, name: 'Cat1') }
      let!(:cat2) { create(:category, highlighted: true, highlight_order: 2, name: 'Cat2') }
      let!(:cat3) { create(:category, highlighted: true, highlight_order: 3, name: 'Cat3') }

      it 'shifts the highlight_order of other categories >= to the new given order' do
        new_category = create(:category, highlighted: true, highlight_order: 2, name: 'NewCat')

        expect(new_category.reload.highlight_order).to eq(2)
        expect(cat1.reload.highlight_order).to eq(1)
        expect(cat2.reload.highlight_order).to eq(3)
        expect(cat3.reload.highlight_order).to eq(4)
      end

      it 'does not shift orders if order is greater than existing' do
        new_category = create(:category, highlighted: true, highlight_order: 4, name: 'NewCat')

        expect(new_category.reload.highlight_order).to eq(4)
        expect(cat1.reload.highlight_order).to eq(1)
        expect(cat2.reload.highlight_order).to eq(2)
        expect(cat3.reload.highlight_order).to eq(3)
      end
    end
  end

  describe 'scopes' do
    describe '.highlighted_ordered' do
      let!(:cat_unhighlighted) { create(:category, highlighted: false, name: 'Unhighlighted') }
      let!(:cat_order2) { create(:category, highlighted: true, highlight_order: 2, name: 'C2') }
      let!(:cat_order1) { create(:category, highlighted: true, highlight_order: 1, name: 'C1') }

      it 'returns highlighted categories in order' do
        expect(Category.highlighted_ordered).to eq([cat_order1, cat_order2])
      end
    end
  end
end
