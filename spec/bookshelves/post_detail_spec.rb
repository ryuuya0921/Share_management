RSpec.describe 'Post Details', type: :request do
  describe 'GET /posts/:id' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user, title: 'テスト投稿', body: 'テスト本文') }

    before do
      sign_in user
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
  end
end
