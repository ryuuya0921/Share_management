require 'rails_helper'

RSpec.describe 'Followers', type: :request do
  let(:user) { create(:user) }
  let(:follower) { create(:user) }
  let(:non_follower) { create(:user) }

  before do
    follower.following << user

    user.following << follower

    sign_in(user)
  end

  describe 'GET /users/:id/followers' do
    it 'フォロワー解除ボタンが表示されること' do
      get followers_user_path(user.id)

      expect(response.body).to include('フォロー解除')
    end

    it '非フォロワーにフォローボタンが表示されること' do
      get followers_user_path(user.id)

      expect(response.body).to include('フォロー')
    end
  end
end
