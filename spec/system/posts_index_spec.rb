require 'rails_helper'

RSpec.describe 'Posts Index', type: :system do
  let(:user) { create(:user) }
  let!(:post1) { create(:post, category: '小説', genre: '冒険', title: '感動の冒険', user: user) }
  let!(:post2) { create(:post, category: '映画', genre: 'ドラマ', title: '感動の物語', user: user) }

  before do
    sign_in user
  end

  describe '本棚の公開/非公開切り替え' do
    it '本棚の公開状態を切り替えられること' do
      visit posts_path

      # 初期状態の確認
      expect(page).to have_content('本棚の公開設定: 非公開中です')

      # 公開に切り替え
      click_button '本棚を公開にする'
      expect(page).to have_content('本棚の公開設定: 公開中です')

      # 非公開に切り替え
      click_button '本棚を非公開にする'
      expect(page).to have_content('本棚の公開設定: 非公開中です')
    end
  end

  describe '検索機能' do
    it 'カテゴリー検索が機能する' do
      visit posts_path
      select '小説', from: 'category'
      click_button '検索'
      expect(page).to have_content(post1.title)
      expect(page).not_to have_content(post2.title)
    end

    it 'ジャンル検索が機能する' do
      visit posts_path
      select '冒険', from: 'genre'
      click_button '検索'
      expect(page).to have_content(post1.title)
      expect(page).not_to have_content(post2.title)
    end

    it 'キーワード検索が機能する' do
      visit posts_path
      fill_in 'keyword', with: '感動'
      click_button '検索'
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)
    end

    it 'カテゴリーとジャンルの検索条件を組み合わせられること' do
      visit posts_path
      select '小説', from: 'category'
      select '冒険', from: 'genre'
      click_button '検索'

      expect(page).to have_content(post1.title)
      expect(page).not_to have_content(post2.title)
    end
  end

  describe '検索結果の並び順' do
    it '検索結果が最新順で表示されること' do
      visit posts_path(sort: 'latest')
      titles = page.all('.card-title').map(&:text)
      expect(titles).to eq([post2.title, post1.title])
    end

    it '検索結果が過去順で表示されること' do
      visit posts_path(sort: 'oldest')
      titles = page.all('.card-title').map(&:text)
      expect(titles).to eq([post1.title, post2.title])
    end
  end

  it 'ページネーションが正しく動作すること' do
    create_list(:post, 15, user: user)
    visit posts_path

    expect(page).to have_selector('.pagination')
    click_link '2'
    expect(page).to have_current_path(posts_path(page: 2))
  end
end
