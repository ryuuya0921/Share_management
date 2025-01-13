require 'rails_helper'

RSpec.describe 'PlazaPosts', type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it 'ユーザーが投稿を作成し詳細ページを表示できる' do
    visit new_plaza_post_path

    fill_in 'タイトル', with: 'テスト投稿'
    fill_in '内容', with: 'これはテスト内容です。'

    click_button '投稿する'

    expect(page).to have_content '投稿が作成されました。'
    expect(page).to have_content 'テスト投稿'
    expect(page).to have_content 'これはテスト内容です。'

    expect(page).to have_content user.name
  end
end
