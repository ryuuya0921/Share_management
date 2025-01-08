require 'rails_helper'

RSpec.describe 'PlazaPosts', type: :request do
  let(:user) { create(:user) }
  let(:plaza_post) { create(:plaza_post, user: user) }
  let!(:comments) { create_list(:comment, 15, plaza_post: plaza_post, user: user) }

  describe 'GET /plaza_posts/:id' do
    context 'ログインしているユーザーが投稿の詳細ページにアクセスする場合' do
      before do
        sign_in user
        get plaza_post_path(plaza_post)
      end

      it '投稿のタイトルが表示される' do
        expect(response.body).to include(plaza_post.title)
      end

      it '投稿の内容が表示される' do
        expect(response.body).to include(plaza_post.content)
      end

      it 'コメントが表示される' do
        comments.each do |comment|
          expect(response.body).to include(comment.content)
        end
      end

      it 'ページネーションが正しく表示される' do
        expect(response.body).to include('<ul class="pagination">')
      end

      it 'コメントの「いいね」数が表示される' do
        comments.each do |comment|
          expect(response.body).to include("いいね数: #{comment.votes_for.size}")
        end
      end

      it '投稿に対する編集リンクが表示される' do
        expect(response.body).to include(edit_plaza_post_path(plaza_post))
      end

      it '投稿に対する削除リンクが表示される' do
        expect(response.body).to include("data-method=\"delete\" href=\"#{plaza_post_path(plaza_post)}\"")
      end

      it '他のユーザーの投稿には編集リンクと削除リンクが表示されない' do
        other_user = create(:user)
        other_post = create(:plaza_post, user: other_user)
        get plaza_post_path(other_post)
        expect(response.body).not_to include(edit_plaza_post_path(other_post))
        expect(response.body).not_to include("data-method=\"delete\" href=\"#{plaza_post_path(other_post)}\"")
      end

      it '新しいコメントを投稿するフォームが表示される' do
        expect(response.body).to include('新しいコメントを投稿')
        expect(response.body).to include('<textarea class="form-control" name="comment[content]')
      end

      it '「みんなの広場に戻る」リンクが表示される' do
        expect(response.body).to include('みんなの広場に戻る')
      end
    end
  end
end
