require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user, bookshelf_public: true) }
  let!(:post1) { create(:post, user: user, title: '感動の映画', category: '映画', genre: 'ドラマ', public: true) }
  let!(:post2) { create(:post, user: user, title: '面白いアニメ', category: 'アニメ', genre: 'コメディ', public: false) }
  let!(:post3) { create(:post, user: user, title: '感動の本', category: '書籍', genre: '小説', public: true) }

  before do
    sign_in user
  end

  describe 'GET /posts' do
    context '投稿一覧ページにアクセスする場合' do
      before do
        get posts_path
      end

      it 'ページが正常に表示される' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('思い出の図書館')
        expect(response.body).to include('新規作成')
        expect(response.body).to include('公開中')
        expect(response.body).to include('非公開中')
      end

      it '投稿が表示される' do
        expect(response.body).to include(post1.title)
        expect(response.body).to include(post2.title)
        expect(response.body).to include(post3.title)
      end

      it '公開中の投稿が表示される' do
        get posts_path(status: 'public')
        expect(response.body).to include(post1.title)
        expect(response.body).to include(post3.title)
        expect(response.body).not_to include(post2.title)
      end

      it '非公開中の投稿が表示される' do
        get posts_path(status: 'private')
        expect(response.body).to include(post2.title)
        expect(response.body).not_to include(post1.title)
        expect(response.body).not_to include(post3.title)
      end

      it 'すべての投稿が表示される' do
        get posts_path
        expect(response.body).to include(post1.title)
        expect(response.body).to include(post2.title)
        expect(response.body).to include(post3.title)
      end

      it 'カテゴリーで検索できる' do
        get posts_path(category: '映画')
        expect(response.body).to include(post1.title)
        expect(response.body).not_to include(post2.title)
        expect(response.body).not_to include(post3.title)
      end

      it 'ジャンルで検索できる' do
        get posts_path(genre: 'コメディ')
        expect(response.body).to include(post2.title)
        expect(response.body).not_to include(post1.title)
        expect(response.body).not_to include(post3.title)
      end

      it 'ワード検索ができる' do
        get posts_path(keyword: '感動')
        expect(response.body).to include(post1.title)
        expect(response.body).to include(post3.title)
        expect(response.body).not_to include(post2.title)
      end

      it 'ページネーションが正しく表示される' do
        create_list(:post, 25, user: user)
        get posts_path(page: 2)
        expect(response.body).to include('<ul class="pagination">')
      end
    end
  end

  context '本棚の公開設定を切り替える場合' do
    it '公開設定が切り替わる' do
      expect(user.bookshelf_public).to be_truthy
      post toggle_bookshelf_visibility_posts_path
      user.reload
      expect(user.bookshelf_public).to be_falsey
    end

    it '非公開設定が切り替わる' do
      user.update(bookshelf_public: true)
      post toggle_bookshelf_visibility_posts_path
      user.reload
      expect(user.bookshelf_public).to be_falsey
    end
  end
end
