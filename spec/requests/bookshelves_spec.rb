require 'rails_helper'

RSpec.describe "Bookshelves", type: :request do
  describe "GET /bookshelves" do
    it "returns 200 OK" do
      # ログインユーザーと他のユーザーを作成
      current_user = create(:user) # ログイン中のユーザー
      other_user = create(:user)  # 他のユーザー
      create(:post, user: other_user, public: true) # 他のユーザーの公開投稿を作成

      # ログインをシミュレート
      sign_in current_user

      # GETリクエストを送信
      get bookshelves_path

      # ステータスコードが200であることを確認
      expect(response).to have_http_status(:ok)
    end
  end
end
