require 'rails_helper'

RSpec.describe '投稿編集ページ', type: :system do
  let(:user) { create(:user) }
  let!(:post) do
    create(:post,
           user: user,
           title: '編集前のタイトル',
           category: '映画',
           genre: 'アクション',
           body: '編集前の内容',
           public: true)
  end

  before do
    sign_in user
  end

  describe '投稿の編集' do
    it '正しい情報を入力すると投稿が更新される' do
      visit edit_post_path(post)

      expect(find_field('タイトル').value).to eq '編集前のタイトル'
      expect(find_field('カテゴリー').value).to eq '映画'
      expect(find_field('ジャンル').value).to eq 'アクション'
      expect(find_field('内容（800文字以内）').value).to eq '編集前の内容'

      # 情報を更新
      fill_in 'タイトル', with: '編集後のタイトル'
      select 'アニメ', from: 'カテゴリー'
      select 'ファンタジー', from: 'ジャンル'
      fill_in '内容（800文字以内）', with: '編集後の内容'
      select '非公開', from: '公開設定'

      click_button '更新する'

      # 更新完了の確認
      expect(page).to have_content('投稿が更新されました')
      expect(page).to have_content('編集後のタイトル')
      expect(page).to have_content('編集後の内容')
      expect(page).to have_content('非公開中')
    end

    it '必須項目が未入力の場合、エラーメッセージが表示される' do
      visit edit_post_path(post)

      fill_in 'タイトル', with: ''
      click_button '更新する'

      expect(page).to have_content('タイトルを入力してください')
    end

    it '添付画像を削除できる' do
      # 画像を添付
      post.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')), filename: 'test_image.png')
    
      # 添付されていることを確認
      expect(post.image.attached?).to be_truthy
    
      # 編集ページに移動
      visit edit_post_path(post)
    
      # 画像削除を選択
      check '画像を削除する'
      click_button '更新する'
    
      # デバッグ: テスト中のHTMLを出力
      puts page.html
    
      # 再読み込みして画像が削除されていることを確認
      post.reload
      expect(post.image.attached?).to be_falsey
    end
  end
end
