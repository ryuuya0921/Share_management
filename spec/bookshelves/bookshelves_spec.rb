require 'rails_helper'

RSpec.describe 'Bookshelves', type: :request do
  describe 'GET /bookshelves' do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:public_post) { create(:post, user: other_user, public: true) }

    before do
      sign_in current_user
      get bookshelves_path
    end

    it 'ステータスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'ページのタイトルが正しいこと' do
      expect(response.body).to include('思い出の図書館 - みんなの本棚')
    end

    it '他のユーザーの本棚が表示されていること' do
      expect(response.body).to include("#{other_user.name} の本棚")
    end

    it '投稿数が正しく表示されていること' do
      expect(response.body).to include("投稿数: #{other_user.posts.where(public: true).count}")
    end
  end
end
