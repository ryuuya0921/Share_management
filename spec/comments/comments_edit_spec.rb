require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'PATCH /plaza_posts/:plaza_post_id/comments/:id' do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:plaza_post) { create(:plaza_post, user: current_user) }
    let!(:comment) { create(:comment, plaza_post: plaza_post, user: current_user, content: '元のコメント') }

    before do
      sign_in current_user
    end

    context '有効なパラメータの場合' do
      let(:valid_params) { { comment: { content: '編集されたコメント' } } }

      it 'ステータスコードが302であること (リダイレクト)' do
        patch plaza_post_comment_path(plaza_post, comment), params: valid_params
        expect(response).to have_http_status(:found)
      end

      it 'コメントが更新されること' do
        expect do
          patch plaza_post_comment_path(plaza_post, comment), params: valid_params
        end.to change { comment.reload.content }.from('元のコメント').to('編集されたコメント')
      end

      it '正しいリダイレクト先にリダイレクトすること' do
        patch plaza_post_comment_path(plaza_post, comment), params: valid_params
        expect(response).to redirect_to(plaza_post_path(plaza_post))
      end
    end

    context '無効なパラメータの場合' do
      let(:invalid_params) { { comment: { content: '' } } }

      it 'コメントが更新されないこと' do
        expect { patch plaza_post_comment_path(plaza_post, comment), params: invalid_params }
          .not_to(change { comment.reload.content })
      end

      it 'エラーメッセージが表示されること' do
        patch plaza_post_comment_path(plaza_post, comment), params: invalid_params

        expect(response.body).to include('コメントの更新に失敗しました。')
        expect(response.body).to include('field_with_errors')
      end

      it 'ステータスコードが422であること' do
        patch plaza_post_comment_path(plaza_post, comment), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
