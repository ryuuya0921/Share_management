RSpec.describe 'Post Details', type: :request do
  describe 'GET /posts/:id' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user, title: 'テスト投稿', body: 'テスト本文') }

    before do
      sign_in user
      allow_any_instance_of(User).to receive(:voted_for?).and_return(false)
      get post_path(post)
    end

    it 'ステータスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it '投稿のタイトルが表示されていること' do
      expect(response.body).to include(post.title)
    end

    it '投稿の本文が表示されていること' do
      expect(response.body).to include(post.body)
    end

    context '画像が添付されている場合' do
      let(:post_with_image) { create(:post, user: user, image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png')) }

      before do
        get post_path(post_with_image)
      end

      it '投稿画像が表示されていること' do
        expect(response.body).to include('test_image.png')
      end
    end

    context '画像が添付されていない場合' do
      it 'デフォルト画像が表示されていること' do
        default_image_path = ActionController::Base.helpers.asset_path('book_01_brown.png')
        expect(response.body).to include(default_image_path)
      end
    end

    it '戻るボタンが表示されていること' do
      expect(response.body).to include('戻る')
    end

  end
end
