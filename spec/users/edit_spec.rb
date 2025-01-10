require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:guest_user) { create(:user, email: 'guest@example.com') }

  before do
    sign_in user
  end

  describe 'GET /users/edit' do
    it 'プロフィール編集ページが表示される' do
      get edit_user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('名前')
      expect(response.body).to include('プロフィール画像')
      expect(response.body).to include('自己紹介')
      expect(response.body).to include('更新')
    end
  end

  describe 'PATCH /users' do
    context 'ユーザーがプロフィールを更新する場合' do
      it 'プロフィールが更新される' do
        patch user_path(user), params: { user: { name: '新しい名前', bio: '新しい自己紹介' } }
        user.reload
        expect(user.name).to eq('新しい名前')
        expect(user.bio).to eq('新しい自己紹介')
        expect(response).to redirect_to(profile_path(user))
      end
    end

    context 'ゲストユーザーがプロフィールを更新しようとする場合' do
      before do
        sign_in guest_user
      end

      it '名前が変更できない' do
        patch user_path(guest_user), params: { user: { name: '変更された名前' } }
        guest_user.reload
        expect(guest_user.name).not_to eq('変更された名前')

        follow_redirect!

        expect(response.body).to include('ゲストユーザー様は名前の変更はできません')
      end
    end
  end
end
