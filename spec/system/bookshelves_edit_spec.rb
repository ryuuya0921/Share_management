require 'rails_helper'

RSpec.describe 'コメント編集', type: :system do
  let(:current_user) { create(:user) }
  let(:plaza_post) { create(:plaza_post, user: current_user) }
  let!(:comment) { create(:comment, plaza_post: plaza_post, user: current_user, content: '元のコメント内容') }

  before do
    driven_by(:selenium_chrome)
    sign_in current_user
    visit edit_plaza_post_comment_path(plaza_post, comment)
  end

  it 'フォームが正しく表示される' do
    expect(page).to have_content('コメントを編集')
    expect(page).to have_selector('form')
    expect(page).to have_field('コメント内容', with: '元のコメント内容')
    expect(page).to have_button('更新')
    expect(page).to have_link('キャンセル', href: plaza_post_path(plaza_post))
  end

  it 'コメントを正常に編集できる' do
    fill_in 'コメント内容', with: '編集後のコメント内容'
    click_button '更新'

    expect(page).to have_current_path(plaza_post_path(plaza_post))
    expect(page).to have_content('編集後のコメント内容')
    expect(page).to have_content('コメントが更新されました。') # 成功メッセージを期待
  end

  it '編集をキャンセルできる' do
    click_link 'キャンセル'

    expect(page).to have_current_path(plaza_post_path(plaza_post))
    expect(page).to have_content('元のコメント内容')
  end
end
