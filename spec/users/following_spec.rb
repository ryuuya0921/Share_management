require 'rails_helper'

RSpec.describe 'Following', type: :request do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:non_followed_user) { create(:user) }

  before do
    user.following << followed_user

    sign_in(user)
  end

  describe 'GET /users/:id/following' do
    it 'フォロー中のユーザー一覧ページが成功すること' do
      get following_user_path(user.id)

      expect(response).to have_http_status(:success)
    end

    it 'フォロー中のユーザーが正しく表示されること' do
      get following_user_path(user.id)

      expect(response.body).to include(followed_user.name)
    end

    it 'フォロー解除ボタンが表示されること' do
      get following_user_path(user.id)

      expect(response.body).to include('フォロー解除')
    end

    it 'フォローボタンが非フォロー中のユーザーに表示されること' do
      get following_user_path(user.id)

      expect(response.body).to include('フォロー')
    end
  end
end
