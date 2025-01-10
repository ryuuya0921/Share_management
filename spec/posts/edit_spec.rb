require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, title: '感動の映画', category: '映画', genre: 'ドラマ', public: true) }

  before do
    sign_in user
  end

  describe 'GET /posts/:id/edit' do
    context '投稿編集ページにアクセスする場合' do
      before do
        get edit_post_path(post)
      end

      it 'ページが正常に表示される' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('投稿を編集')
        expect(response.body).to include(post.title)
      end

      it '編集フォームが正しく表示される' do
        expect(response.body).to include('form')
        expect(response.body).to include(post.title)
        expect(response.body).to include(post.category)
        expect(response.body).to include(post.genre)
      end
    end
  end
end
