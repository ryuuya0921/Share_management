require 'rails_helper'

RSpec.describe '投稿編集', type: :system do
  let(:current_user) { create(:user) }
  let(:plaza_post) { create(:plaza_post, user: current_user, title: '元のタイトル', content: '元の内容') }

  before do
    driven_by(:selenium_chrome)
    sign_in current_user
    visit edit_plaza_post_path(plaza_post)
  end

  it 'フォームが正しく表示される' do
    expect(page).to have_content('投稿の編集')
    expect(page).to have_selector('form')
    expect(page).to have_field('タイトル', with: '元のタイトル')
    expect(page).to have_field('内容', with: '元の内容')
    expect(page).to have_button('更新')
    expect(page).to have_link('キャンセル', href: plaza_post_path(plaza_post))
  end

  it '投稿を正常に編集できる' do
    fill_in 'タイトル', with: '編集後のタイトル'
    fill_in '内容', with: '編集後の内容'
    click_button '更新'

    expect(page).to have_current_path(plaza_post_path(plaza_post))
    expect(page).to have_content('編集後のタイトル')
    expect(page).to have_content('編集後の内容')
    expect(page).to have_content('投稿が更新されました。') # 成功メッセージ
  end

  it '編集をキャンセルできる' do
    click_link 'キャンセル'

    expect(page).to have_current_path(plaza_post_path(plaza_post))
    expect(page).to have_content('元のタイトル')
    expect(page).to have_content('元の内容')
  end
end
