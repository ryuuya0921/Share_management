require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let(:post_params) do
    {
      title: '感動の映画',
      category: '映画',
      genre: 'ドラマ',
      body: '映画の感想',
      public: true
    }
  end

  before do
    sign_in user
  end

  describe 'GET /posts/new' do
    it '新規投稿フォームが表示される' do
      get new_post_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('タイトル')
      expect(response.body).to include('カテゴリー')
      expect(response.body).to include('ジャンル')
      expect(response.body).to include('内容（800文字以内）')
      expect(response.body).to include('画像')
      expect(response.body).to include('公開設定')
    end
  end

  describe 'POST /posts' do
    context '有効なパラメータで投稿する場合' do
      it '新しい投稿が作成される' do
        expect do
          post posts_path, params: { post: post_params }
        end.to change(Post, :count).by(1)

        expect(response).to redirect_to(post_path(Post.last))
        follow_redirect!

        expect(response.body).to include('感動の映画')
        expect(response.body).to include('映画の感想')
      end
    end

    context '無効なパラメータで投稿する場合' do
      it 'エラーメッセージが表示される' do
        invalid_params = post_params.merge(title: '')
        post posts_path, params: { post: invalid_params }

        expect(response.body).to include('タイトルを入力してください')
      end
    end
  end

  describe 'GET /posts/:id/edit' do
    let!(:post) { create(:post, user: user, title: '感動の映画', category: '映画', genre: 'ドラマ', body: '映画の感想', public: true) }

    it '投稿編集フォームが表示される' do
      get edit_post_path(post)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('感動の映画')
      expect(response.body).to include('映画')
      expect(response.body).to include('ドラマ')
      expect(response.body).to include('映画の感想')
    end
  end

  describe 'PATCH /posts/:id' do
    let!(:post) { create(:post, user: user, title: '感動の映画', category: '映画', genre: 'ドラマ', body: '映画の感想', public: true) }

    context '有効なパラメータで投稿を更新する場合' do
      it '投稿が更新される' do
        patch post_path(post), params: { post: post_params.merge(title: '新しい映画') }
        post.reload

        expect(post.title).to eq('新しい映画')
        expect(response).to redirect_to(post_path(post))
        follow_redirect!

        expect(response.body).to include('新しい映画')
      end
    end

    context '無効なパラメータで投稿を更新する場合' do
      it 'エラーメッセージが表示される' do
        patch post_path(post), params: { post: post_params.merge(title: '') }
        expect(response.body).to include('タイトルを入力してください')
      end
    end
  end

  describe '画像の削除' do
    let!(:post_with_image) do
      create(:post,
             user: user,
             image: fixture_file_upload('spec/fixtures/files/test_image.png', 'image/png'),
             title: '感動の映画',
             category: '映画',
             genre: 'ドラマ',
             body: '映画の感想...',
             public: true)
    end
    it '画像を削除する' do
      expect(post_with_image.image.attached?).to be_truthy

      patch post_path(post_with_image), params: { post: { remove_image: '1' } }
      post_with_image.reload
      expect(post_with_image.image.attached?).to be_falsey
    end
  end
end
