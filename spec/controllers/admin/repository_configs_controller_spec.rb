require 'rails_helper'

RSpec.describe Admin::RepositoryConfigsController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #index' do
    let(:params) do
      {
        page: 5,
        per_page: 20
      }
    end
    let(:repository_configs) do
      {
        'data' => [],
        'meta' => {
          'total_count' => 0,
          'page' => 1,
          'per_page' => 20
        }
      }
    end

    subject { get :index, params: params }

    before do
      allow_any_instance_of(described_class).to receive(:get_repositories_with_pagination).and_return(repository_configs)
    end

    context 'when success' do
      it 'should assigns repositories' do
        subject

        repositories = assigns(:repositories)
        expect(repositories).to eq []
        expect(response).to render_template :index
      end
    end

    context 'when missing params' do
      let(:params) { {} }

      it 'should assigns repositories' do
        subject

        repositories = assigns(:repositories)
        expect(repositories).to eq []
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #edit' do
    let(:params) do
      {
        id: 1
      }
    end
    let(:repository_config) do
      {
        'data' => {
          'id' => 1,
          'name' => 'test',
          'format' => 'text',
          'repository_id' => 1
        }
      }
    end

    subject { get :edit, params: params }

    before do
      allow_any_instance_of(described_class).to receive(:get_repository).and_return(repository_config)
    end

    context 'when success' do
      it 'should assigns repository' do
        subject

        repository = assigns(:repository)
        expect(repository).to eq repository_config['data']
        expect(response).to render_template :edit
      end
    end
  end
end
