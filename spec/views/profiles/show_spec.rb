require 'rails_helper'

RSpec.describe 'profiles/show', type: :view do
  let(:user) { create(:user, bio: '私のプロフィールです！', profile_image: nil) }
  let(:user_with_image) do
    create(:user, bio: 'プロフィール画像あり',
                  profile_image: fixture_file_upload('spec/fixtures/files/test_image.png', 'image/png'))
  end

  before do
    assign(:user, user)
  end

  context 'プロフィールページが表示される場合' do
    it 'ユーザー名、自己紹介、フォロワー数、フォロー数が表示される' do
      render

      expect(rendered).to include("#{user.name}のプロフィール")
      expect(rendered).to include('自己紹介')
      expect(rendered).to include(user.bio)
      expect(rendered).to include('フォロワー (0)')
      expect(rendered).to include('フォロー (0)')
      expect(rendered).to include('プロフィールを編集')
    end

    it '画像が設定されていない場合、画像設定メッセージが表示される' do
      render

      expect(rendered).to include('編集からアイコンを設定しよう！')
    end
  end

  context 'プロフィール画像が設定されている場合' do
    before do
      assign(:user, user_with_image)
      render
    end

    it 'プロフィール画像が表示される' do
      expect(rendered).to include(user_with_image.profile_image.filename.to_s)
      expect(rendered).to include('プロフィール画像')
    end
  end
end
