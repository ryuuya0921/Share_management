require 'rails_helper'

RSpec.describe 'フォロー中のユーザー一覧', type: :system do
  let!(:user) { create(:user, name: 'テストユーザー') }
  let!(:following1) { create(:user, name: 'フォロー中のユーザー1') }

  before do
    user.follow(following1)
    login_as(user)
  end

  it 'フォロー解除操作をフォロー中のユーザー1で確認する' do
    visit following_user_path(user)

    within 'ul.list-group' do
      # ユーザーが表示されているか確認
      expect(page).to have_content('フォロー中のユーザー1')

      expect(page).to have_button('フォロー解除')

      click_button 'フォロー解除'
    end
  end

  it '戻るリンクが正しいURLに遷移する' do
    visit following_user_path(user)

    click_link '戻る'

    expect(current_path).to eq(following_user_path(user))
  end
end
