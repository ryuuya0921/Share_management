require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /users/show' do
    it 'プロフィールページが表示される' do
      get user_path(user)

      # ヘッダーが表示されることを確認
      expect(response.body).to include("ようこそ、#{user.name} さん。思い出の図書館へ！")
      expect(response.body).to include("#{user.name} さんのお気に入りの作品を記録しましょう。")

      # 自分の本棚セクションのリンクとテキストが表示されることを確認
      expect(response.body).to include("#{user.name} さんの本棚")
      expect(response.body).to include('「本棚」は、あなたがこれまでに観た映画、アニメ、ドラマ、本についての感想を記録する場所です。')
      expect(response.body).to include('お気に入りの作品や、忘れたくない作品の思い出を残しましょう。')
      expect(response.body).to include('自分だけの「思い出の図書館」を作ってみてください！')

      # みんなの本棚セクションのリンクとテキストが表示されることを確認
      expect(response.body).to include('みんなの本棚を見る')
      expect(response.body).to include('他のユーザーがどんな作品に興味を持ち、感想を記録しているかを見てみましょう。')
      expect(response.body).to include('共感できる作品や新しい発見が待っているかもしれません！')

      # みんなの広場セクションのリンクとテキストが表示されることを確認
      expect(response.body).to include('みんなの広場')
      expect(response.body).to include('「みんなの広場」では、作品についての感想や意見を他のユーザーと共有できます。')
      expect(response.body).to include('あなたが感動した作品について語り合ったり、他のユーザーの感想を読んで新しい作品と出会うことができます。')
      expect(response.body).to include('みんなでお気に入りの作品を語り合いましょう！')
    end
  end
end
