# 思い出の図書館

## 概要
思い出の図書館はこれまで見た映画、アニメ、漫画、本の感想を記録し、共有できる管理型共有アプリです。
ユーザー同士が作品の感想を共有し、共感や交流を深められる場を提供します。

## 開発の背景・目的
近年、映画・アニメ・漫画・小説といったエンタメ作品の情報共有が活発になり、SNSやレビューサイトを通じて感想を発信する文化が広がっています。しかし、個人が「観た・読んだ作品を管理し、振り返る」ためのツールは少ないのが現状であると思います。
私自身、映画や漫画、アニメを通じて多くの友人とつながり、会話の中で過去の作品の話題になることがよくあります。しかし、「どんな話だったか思い出せない」「どの作品をいつ観たのか記録しておけばよかった」と感じる場面も多くありました。
そこで、自分だけの作品ライブラリを作成し、感想や評価を記録・共有できるアプリを開発しました。本アプリは、個人の記録ツールとしての役割だけでなく、共通の作品を好きなユーザー同士がつながる場 を提供し、作品を通じた新たな交流を生み出すことを目的としています。

### 作品
GitHub

https://github.com/ryuuya0921/Share_management

サイトURL

https://www.omoide-toshokan.com

## 機能一覧
#### ユーザー認証機能(Devise)
- ログイン / サインアップ
- ゲストログイン機能

#### プロフィール機能
- ユーザーのプロフィール作成・編集
- 画像アップロード機能 (Active Storage + AWS S3)

#### 投稿・本棚機能
- 映画、アニメ、漫画、小説ごとに本棚を作成
- 各投稿へのいいね！機能
- フォロー / フォロワー機能
- 感想の投稿 (CRUD)
- コメント機能 (他のユーザーが感想に対して追記可能)
- ワード検索機能
- 投稿 / 本棚の閲覧数表示

#### その他機能
- ページネーション (kaminari)
- UIデザイン (Bootstrap, Tailwind CSS)
- レスポンシブ対応

## 使用技術

| カテゴリ | 使用技術・ツール |
|----------|----------------|
| **フレームワーク** | Ruby on Rails 7.0.8 |
| **プログラミング言語** | Ruby 3.2.2, HTML, CSS |
| **データベース** | PostgreSQL (本番環境), SQLite3 (開発・テスト環境) |
| **ウェブサーバー** | Puma |
| **フロントエンド** | Bootstrap 5.3.0, Turbo Rails, Stimulus |
| **認証・認可** | Devise (ユーザー認証) |
| **パスワード管理** | bcrypt |
| **画像・ストレージ** | Active Storage, AWS S3, ImageMagick, libvips |
| **ページネーション** | Kaminari, Kaminari Bootstrap |
| **投票・ランキング機能** | acts_as_votable (いいね機能) |
| **検索機能** | ransack (投稿・ユーザー検索) |
| **メール送信・デバッグ** | Letter Opener (開発環境用) |
| **API関連** | Jbuilder (JSON API作成) |
| **JavaScriptモジュール管理** | Importmap-Rails |
| **パフォーマンス最適化** | Bootsnap, rack-mini-profiler |
| **テスト** | RSpec, Capybara, FactoryBot, Faker, Selenium WebDriver |
| **コーディングスタイルチェック** | Rubocop, Rubocop-Rails |
| **開発支援** | Web Console (エラー時のデバッグ), Debug |
| **CSSプリプロセッサ** | dartsass-sprockets |
| **バンドル管理** | Bundler |
| **デプロイ** | Heroku, AWS S3 |

## 機能紹介
ログインページ

- deviceを使用したログイン機能です。メールアドレスログイン、ゲストログインを実装。
  
![ログインデモ](https://github.com/user-attachments/assets/2afd340c-c01a-455a-9efd-5a7517696869)

### パスワード再設定

- パスワード再設定機能の実装
- ユーザーがパスワードを忘れた場合にリセット可能

<img src="https://github.com/user-attachments/assets/a07c79b8-b951-4645-a950-ff98fd7368c9" width="300">

### 本棚へ登録
- 新規登録を行い、作成した作品を本棚に表示することができます。また「公開・非公開」を選択することで、個別に他ユーザーへ公開するかどうか？設定できます。

<img src="https://github.com/user-attachments/assets/442bbb27-5a21-4623-877d-978210f48375" style="width:50%;">

- 本棚自体を他ユーザーへ「公開・非公開」設定することもできます。

<img src="https://github.com/user-attachments/assets/7553ba95-5fc2-4a54-b6b2-ba3c91769dfb" style="width:50%;">

