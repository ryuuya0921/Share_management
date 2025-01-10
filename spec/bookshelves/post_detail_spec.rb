RSpec.describe 'Post Details - Images', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:, title: 'テスト投稿', body: 'テスト本文') }

  before do
    sign_in user
    allow_any_instance_of(User).to receive(:voted_for?).and_return(false)
  end

  describe 'GET /posts/:id' do
    context '正常な場合' do
      before { get post_path(post) }

      it 'ステータスコードが200であること' do
        expect(response).to have_http_status(:ok)
      end

      it '投稿のタイトルが表示されていること' do
        expect(response.body).to include(post.title)
      end
    end

    context '画像が添付されている場合' do
      let(:post_with_image) do
        create(:post, user:, image: fixture_file_upload(
          Rails.root.join('spec/fixtures/files/test_image.png'),
          'image/png'
        ))
      end

      before { get post_path(post_with_image) }

      it '投稿画像が表示されていること' do
        expect(response.body).to include('test_image.png')
      end
    end

    context '画像が添付されていない場合' do
      let(:post_without_image) { create(:post, user:) }

      before { get post_path(post_without_image) }

      it 'デフォルト画像が表示されていること' do
        default_image_path = ActionController::Base.helpers.asset_path('book_01_brown.png')
        expect(response.body).to include(default_image_path)
      end
    end
  end
end
