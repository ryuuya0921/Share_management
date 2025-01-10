require 'rails_helper'

RSpec.describe 'PlazaPosts#index', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:post1) { create(:plaza_post, user: user, title: '感動の映画', content: '素晴らしい映画でした。') }
  let!(:post2) { create(:plaza_post, user: other_user, title: '面白いアニメ', content: '笑いが止まりませんでした。') }
  let!(:post3) { create(:plaza_post, user: user, title: '感動の本', content: '涙が出ました。') }

  before do
    sign_in user
  end

  describe 'GET /plaza_posts' do
    context '通常のリクエストの場合' do
      it 'ページが正常に表示されること' do
        get plaza_posts_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('みんなの広場')
        expect(response.body).to include('新しい投稿を作成する')
        expect(response.body).to include(post1.title)
        expect(response.body).to include(post2.title)
      end
    end

    context 'キーワード検索を実行した場合' do
      it '該当する投稿のみが表示されること' do
        get plaza_posts_path, params: { search_word: '感動' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(post1.title)
        expect(response.body).to include(post3.title)
        expect(response.body).not_to include(post2.title)
      end
    end

    context 'ページネーションを使用する場合' do
      before do
        create_list(:plaza_post, 12, user: user)
      end

      it '正しいページが表示されること' do
        get plaza_posts_path, params: { page: 2 }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('みんなの広場')
        expect(response.body).to include('現在の合計投稿件数:')
      end
    end

    describe 'GET /plaza_posts' do
      it 'ログインユーザーの投稿の場合、編集と削除リンクが表示されること' do
        get plaza_posts_path
        # 自分の投稿の編集の場合は、削除リンクが表示されることを確認
        expect(response.body).to include(edit_plaza_post_path(post1))
        expect(response.body).to include("data-method=\"delete\" href=\"#{plaza_post_path(post1)}\"")

        # 他のユーザーの投稿の編集の場合は、削除リンクが表示されないことを確認
        expect(response.body).not_to include(edit_plaza_post_path(post2))
        expect(response.body).not_to include("data-method=\"delete\" href=\"#{plaza_post_path(post2)}\"")
      end
    end
  end
end
