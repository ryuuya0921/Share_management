require 'rails_helper'

RSpec.describe 'PlazaPosts Edit', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:plaza_post) { create(:plaza_post, user: user, title: '編集前のタイトル', content: '編集前の内容') }

  before do
    driven_by(:rack_test)
  end

  describe '投稿の編集' do
    context '投稿の所有者の場合' do
      before do
        sign_in user
        visit edit_plaza_post_path(plaza_post)
      end

      it '投稿を正常に編集できること' do
        fill_in 'タイトル', with: '編集後のタイトル'
        fill_in '内容', with: '編集後の内容'
        click_button '更新'

        expect(page).to have_content('投稿が更新されました。')
        expect(page).to have_content('編集後のタイトル')
        expect(page).to have_content('編集後の内容')
        expect(current_path).to eq plaza_post_path(plaza_post)
      end

      it 'タイトルが空の場合、エラーが表示されること' do
        fill_in 'タイトル', with: ''
        click_button '更新'

        expect(page).to have_content('エラーが発生しました')
        expect(page).to have_content('タイトルを入力してください')
      end
    end

    context '投稿の所有者でない場合' do
      before do
        sign_in other_user
      end

      it '編集ページにアクセスできないこと' do
        visit edit_plaza_post_path(plaza_post)

        expect(page).to have_content('編集する権限がありません。')
        expect(current_path).to eq plaza_posts_path
      end
    end
  end
end
