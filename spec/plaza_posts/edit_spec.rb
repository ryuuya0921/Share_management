require 'rails_helper'

RSpec.describe 'PlazaPosts', type: :request do
  let(:user) { create(:user) }
  let(:plaza_post) { create(:plaza_post, user: user, title: '元のタイトル', content: '元の内容') }
  let(:valid_params) { { plaza_post: { title: '更新後のタイトル', content: '更新後の内容' } } }
  let(:invalid_params) { { plaza_post: { title: '', content: '' } } }

  before do
    sign_in user
  end

  describe 'GET /plaza_posts/:id/edit' do
    it '編集ページが正常に表示されること' do
      get edit_plaza_post_path(plaza_post)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('投稿の編集', 'タイトル', '内容')
    end
  end

  describe 'PATCH /plaza_posts/:id' do
    context '無効なパラメータの場合' do
      it '投稿が更新されないこと' do
        patch plaza_post_path(plaza_post), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('タイトルを入力してください')
        expect(response.body).to include('内容を入力してください')
      end
    end
  end

  describe 'PATCH /plaza_posts/:id' do
    context '無効なパラメータの場合' do
      let(:invalid_params) { { plaza_post: { title: '', content: '' } } }

      it '投稿が更新されないこと' do
        patch plaza_post_path(plaza_post), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('タイトルを入力してください')
        expect(response.body).to include('内容を入力してください')
      end
    end
  end
end
