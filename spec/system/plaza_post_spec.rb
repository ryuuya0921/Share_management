require 'rails_helper'

RSpec.describe 'Plaza Posts', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:post1) { create(:plaza_post, user: user, title: '感動の映画', content: '素晴らしい映画でした。') }
  let!(:post2) { create(:plaza_post, user: other_user, title: '面白いアニメ', content: '笑いが止まりませんでした。') }
  let!(:post3) { create(:plaza_post, user: user, title: '感動の本', content: '涙が出ました。') }

  before do
    sign_in user
  end

  describe '一覧表示' do
    it '通常のリクエストの場合、全ての投稿が表示されること' do
      visit plaza_posts_path

      expect(page).to have_content('みんなの広場')
      expect(page).to have_content('新しい投稿を作成する')
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)
    end
  end

  describe '検索機能' do
    it 'キーワード検索が機能すること' do
      visit plaza_posts_path
      fill_in 'キーワード検索:', with: '感動'
      click_button '検索'

      expect(page).to have_content(post1.title)
      expect(page).to have_content(post3.title)
      expect(page).not_to have_content(post2.title)
    end
  end

  describe 'ページネーション' do
    before do
      create_list(:plaza_post, 12, user: user)
    end

    it 'ページネーションが機能すること' do
      visit plaza_posts_path
      click_link '2'

      expect(page).to have_content('みんなの広場')
      expect(page).to have_content('現在の合計投稿件数:')
    end
  end

  describe '編集と削除リンク' do
    it 'ログインユーザーの投稿に編集と削除リンクが表示されること' do
      visit plaza_posts_path

      # 自分の投稿の編集・削除リンクが表示されることを確認
      within "#plaza_post_#{post1.id}" do
        expect(page).to have_link('編集', href: edit_plaza_post_path(post1))
        expect(page).to have_link('削除', href: plaza_post_path(post1))
      end

      # 他のユーザーの投稿には編集・削除リンクが表示されないことを確認
      within "#plaza_post_#{post2.id}" do
        expect(page).not_to have_link('編集', href: edit_plaza_post_path(post2))
        expect(page).not_to have_link('削除', href: plaza_post_path(post2))
      end
    end
  end
end
