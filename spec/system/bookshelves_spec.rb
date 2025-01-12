require 'rails_helper'

RSpec.describe 'みんなの本棚', type: :system do
  let(:current_user) { create(:user) }
  let(:user1) { create(:user, name: '太郎', bookshelf_public: true) }
  let(:user2) { create(:user, name: '花子', bookshelf_public: true) }
  let!(:public_post) { create(:post, user: user1, public: true) }
  let!(:private_post) { create(:post, user: user1, public: false) }
  let!(:other_post) { create(:post, user: user2, public: true) }

  before do
    driven_by(:selenium_chrome)
    sign_in current_user
    visit bookshelves_path
  end

  it 'タイトルが正しく表示される' do
    expect(page).to have_title('思い出の図書館 - みんなの本棚')
  end

  it 'ユーザー数が正しく表示される' do
    total_users = User.where.not(id: current_user.id).count
    expect(page).to have_content("みんなの本棚のユーザー数: #{total_users}")
  end

  it '各ユーザーの本棚情報が表示される' do
    within('.bookshelf-list') do
      expect(page).to have_content('太郎 の本棚')
      expect(page).to have_content('投稿数: 1')
      expect(page).to have_content('花子 の本棚')
      expect(page).to have_content('投稿数: 1')
    end
  end

  it '本棚へのリンクが正しく動作する' do
    within('.bookshelf-list') do
      link = find_link('太郎 の本棚')
      puts "リンクのURL: #{link[:href]}"
      click_link '太郎 の本棚'
    end
    puts "現在のパス: #{page.current_path}"
    expect(page).to have_current_path(bookshelf_path(user1))
  end

  it '「自分の本棚に戻る」リンクが正しく動作する' do
    click_link '自分の本棚に戻る'
    expect(page).to have_current_path(posts_path)
  end

  it 'フォローボタンが表示される' do
    within('.bookshelf-list') do
      expect(page).to have_button('フォロー')
    end
  end
end
