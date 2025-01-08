require 'rails_helper'

RSpec.describe 'PlazaPosts', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /plaza_posts/new' do
    it '新しい投稿ページが正常に表示されること' do
      get new_plaza_post_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('新しい投稿')
      expect(response.body).to include('タイトル')
      expect(response.body).to include('内容を入力してください')
    end
  end

  describe 'POST /plaza_posts' do
    context '有効なパラメータの場合' do
      let(:valid_params) do
        { title: '新しい投稿のタイトル', content: '新しい投稿の内容' }
      end

      it '投稿が作成されること' do
        expect do
          post plaza_posts_path, params: { plaza_post: valid_params }
        end.to change(PlazaPost, :count).by(1)

        expect(response).to redirect_to(plaza_post_path(PlazaPost.last))

        follow_redirect!
        expect(response.body).to include('新しい投稿のタイトル')
        expect(response.body).to include('新しい投稿の内容')
      end
    end

    context '無効なパラメータの場合' do
      let(:invalid_params) { { plaza_post: { title: '', content: '' } } }

      it '投稿が作成されないこと' do
        expect do
          post plaza_posts_path, params: invalid_params
        end.to_not change(PlazaPost, :count)

        expect(response.body).to include('タイトルを入力してください')
        expect(response.body).to include('内容を入力してください')
      end
    end
  end
end
