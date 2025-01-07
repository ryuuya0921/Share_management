RSpec.describe 'Bookshelf Page', type: :request do
  let(:user) { create(:user, name: 'テストユーザー', bio: 'テストの自己紹介') }
  let(:post_with_image) do
    create(
      :post,
      user:,
      title: '画像付き投稿',
      category: 'カテゴリ1',
      genre: 'ジャンル1',
      image: fixture_file_upload(
        Rails.root.join('spec/fixtures/files/test_image.png'),
        'image/png'
      )
    )
  end
  let(:post_without_image) do
    create(
      :post,
      user:,
      title: '画像なし投稿',
      category: 'カテゴリ2',
      genre: 'ジャンル2'
    )
  end

  before do
    sign_in user
    allow_any_instance_of(User).to receive(:voted_for?).and_return(false)
  end

  describe 'GET /users/:id/bookshelf' do
    context '正常な場合' do
      before { get bookshelf_path(user) }

      it 'ユーザー名が表示されていること' do
        expect(response.body).to include("#{user.name} さんの本棚")
      end

      it '自己紹介文が表示されていること' do
        expect(response.body).to include(user.bio)
      end
    end

    context '画像が添付されている投稿がある場合' do
      before do
        post_with_image
        get bookshelf_path(user)
      end

      it '投稿画像が表示されていること' do
        expect(response.body).to include('test_image.png')
      end
    end

    context '画像が添付されていない投稿がある場合' do
      before do
        post_without_image
        get bookshelf_path(user)
      end

      it 'デフォルト画像が表示されていること' do
        default_image_path = ActionController::Base.helpers.asset_path('book_01_brown.png')
        expect(response.body).to include(default_image_path)
      end
    end

    context '検索フォームが正しく表示されている場合' do
      before { get bookshelf_path(user) }

      it 'カテゴリー検索フォームが表示されていること' do
        expect(response.body).to include('カテゴリーで検索:')
      end

      it 'ジャンル検索フォームが表示されていること' do
        expect(response.body).to include('ジャンルで検索:')
      end

      it 'ワード検索フォームが表示されていること' do
        expect(response.body).to include('ワード検索:')
      end
    end
  end
end
