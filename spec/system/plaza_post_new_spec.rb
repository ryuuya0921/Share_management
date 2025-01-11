require 'rails_helper'

RSpec.describe 'PlazaPost Creation', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '新しい投稿フォーム' do
    it 'フォームが正しく表示されること' do
      visit new_plaza_post_path

      expect(page).to have_content('新しい投稿')
      expect(page).to have_field('タイトル')
      expect(page).to have_field('内容を入力してください')
      expect(page).to have_button('投稿する')
    end

    it '正常に投稿を作成できること' do
      visit new_plaza_post_path

      fill_in 'タイトル', with: 'テスト投稿'
      fill_in '内容を入力してください', with: 'これはテスト用の投稿です。'
      click_button '投稿する'

      expect(page).to have_content('みんなの広場')
      expect(page).to have_content('テスト投稿')
      expect(page).to have_content('これはテスト用の投稿です。')
    end

    it '入力が不足している場合にエラーが表示されること' do
      visit new_plaza_post_path

      fill_in 'タイトル', with: ''
      fill_in '内容を入力してください', with: ''
      click_button '投稿する'

      expect(page).to have_content('タイトルを入力してください')
      expect(page).to have_content('内容を入力してください')
    end

    it '「みんなの広場に戻る」リンクが正しく動作すること' do
      visit new_plaza_post_path

      # リンクが正しいURLを持つか確認
      expect(page).to have_link('みんなの広場に戻る', href: plaza_posts_path)

      # リンクをクリック
      click_link 'みんなの広場に戻る'

      # ページが正しく遷移したか確認
      expect(page).to have_current_path(plaza_posts_path, ignore_query: true)
    end
  end
end
