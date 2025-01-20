# 思い出の図書館

## 概要
思い出の図書館はこれまで見た映画、アニメ、漫画、本の感想を記録し、共有できる管理型共有アプリです。
ユーザー同士が作品の感想を共有し、共感や交流を深められる場を提供します。

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
