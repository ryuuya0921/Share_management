require 'rails_helper'

RSpec.describe '投稿詳細', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, title: 'テスト投稿', body: '投稿の本文', public: true, user: user) }

  before do
    sign_in user
  end

  it '投稿詳細が正しく表示される' do
    visit post_path(post)

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.body)
    expect(page).to have_content('公開中')
    expect(page).to have_link('戻る', href: posts_path)
  end

  it '画像が表示される' do
    visit post_path(post)

    if post.image.attached?
      expect(page).to have_selector("img[src*='#{post.image.filename}']")
    else
      expect(page).to have_selector("img[src*='book_01_brown']")
    end
  end

  it '非公開状態が正しく表示される' do
    post.update(public: false)
    visit post_path(post)

    expect(page).to have_content('非公開中')
  end
end
