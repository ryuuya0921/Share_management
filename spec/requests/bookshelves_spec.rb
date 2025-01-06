require 'rails_helper'

RSpec.describe 'Bookshelves', type: :request do
  describe 'GET /bookshelves' do
    before do
      # ログインユーザーと他のユーザーを作成
      current_user = create(:user)
      other_user = create(:user)
      create(:post, user: other_user, public: true)

      # ログインをシミュレート
      sign_in current_user

      # GETリクエストを送信
      get bookshelves_path
    end

    it 'ステータスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'ページのタイトルが正しいこと' do
      expect(response.body).to include('思い出の図書館 - みんなの本棚')
    end
  end
end
