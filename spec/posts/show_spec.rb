require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, title: '感動の映画', category: '映画', genre: 'ドラマ', body: '映画の感想', public: true) }

  before do
    sign_in user
  end

  describe 'GET /posts/:id' do
    context '投稿詳細ページにアクセスする場合' do
      before do
        get post_path(post)
      end

      it 'ページが正常に表示される' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('投稿詳細')
        expect(response.body).to include(post.title)
        expect(response.body).to include(post.body)
      end

      it '投稿の画像が表示される' do
        if post.image.attached?
          expect(response.body).to include(post.image.url)
        else
          expect(response.body).to include('book_01_brown')
        end
      end

      it '公開状態が表示される' do
        expect(response.body).to include('公開中')
      end

      it '戻るリンクが表示される' do
        expect(response.body).to include('戻る')
        expect(response.body).to include(posts_path)
      end
    end
  end
end
