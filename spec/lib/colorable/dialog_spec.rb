require "rails_helper"
require "colorable/dialog"

RSpec.describe Dialog, type: :lib do
  describe 'instance methods' do
    describe 'css_class' do
      subject { Dialog.new.css_class(type: type) }
      let(:type) { 'default' }

      context 'when type is default' do
        it 'should return default css class' do
          css_class = subject
          expect(css_class).to eq 'default'
        end
      end

      context 'when type is rainbow' do
        let(:type) { 'rainbow' }
        it 'should return rainbow css class' do
          css_class = subject
          expect(css_class).to eq 'rainbow'
        end
      end
    end
  end

  describe 'class methods' do
    describe 'allowed_options' do
      subject { Dialog.allowed_options }

      context 'when success' do
        it 'should return array of supported options' do
          options = subject
          expect(options).to eq %w(default important warning fun info rainbow)
        end
      end
    end
  end
end
