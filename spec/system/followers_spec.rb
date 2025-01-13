require 'rails_helper'

RSpec.describe 'フォロワー一覧', type: :system do
  let!(:user) { create(:user, name: 'テストユーザー') }
  let!(:follower1) { create(:user, name: 'フォロワー1') }

  before do
    follower1.follow(user)
    login_as(user)
  end

  it 'フォロー操作とフォロー解除操作をフォロワー1で確認する' do
    visit followers_user_path(user)

    within 'ul.list-group' do
      expect(page).to have_button('フォロー', count: 1)

      click_button 'フォロー', match: :first

      expect(page).to have_button('フォロー解除', count: 1)
    end

    within 'ul.list-group' do
      click_button 'フォロー解除', match: :first

      expect(page).to have_button('フォロー', count: 1)
    end
  end

  it '戻るリンクが正しいURLに遷移する' do
    visit followers_user_path(user)

    click_link '戻る'

    expect(current_path).to eq(followers_user_path(user))
  end
end
