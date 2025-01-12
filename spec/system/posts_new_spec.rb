require 'rails_helper'

RSpec.describe '新規投稿ページ', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '新規投稿の作成' do
    it '正しい情報を入力すると投稿が作成できる' do
      visit new_post_path

      # フォームの入力
      fill_in 'タイトル', with: 'テスト投稿'
      select '映画', from: 'カテゴリー'
      select 'アクション', from: 'ジャンル'
      fill_in '内容（800文字以内）', with: 'テスト本文'
      attach_file '画像', Rails.root.join('spec/fixtures/files/test_image.png')
      select '公開', from: '公開設定'

      # 投稿ボタンをクリック
      click_button '投稿する'

      # 投稿完了の確認
      expect(page).to have_content('投稿が作成されました。')
      expect(page).to have_content('テスト投稿')
    end

    it '必須項目が未入力の場合、エラーメッセージが表示される' do
      visit new_post_path

      # フォームを空のまま送信
      click_button '投稿する'

      # エラーメッセージの確認
      expect(page).to have_content('タイトルを入力してください')
      expect(page).to have_content('カテゴリーを選択してください')
      expect(page).to have_content('ジャンルを選択してください')
    end
  end
end
