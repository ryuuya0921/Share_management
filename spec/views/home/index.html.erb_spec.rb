require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    it 'トップページが正しく表示されること' do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('思い出の図書館')
      expect(response.body).to include('あなたの心を動かした映画、アニメ、漫画、本を「思い出の図書館」に記録してみませんか？')
    end

    it '新規登録リンクが正しいこと' do
      get root_path
      expect(response.body).to include(new_user_registration_path)
    end

    it 'ログインリンクが正しいこと' do
      get root_path
      expect(response.body).to include(new_user_session_path)
    end

    it 'ゲストログインリンクが正しいこと' do
      get root_path
      expect(response.body).to include(users_guest_sign_in_path)
    end
  end
end
