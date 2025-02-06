# Gemのソースを指定
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# 使用するRubyのバージョン
ruby '3.2.2'

# AWS S3を使用するためのGem
gem 'aws-sdk-s3', '~> 1.123'

# データベースアダプタ
gem 'pg', '~> 1.2', group: :production # 本番環境
gem 'sqlite3', '~> 1.4', group: %i[development test] # 開発・テスト環境

# 画像処理
gem 'image_processing', '~> 1.2'

# ページネーション
gem 'kaminari'
gem 'kaminari-bootstrap'

# いいね機能
gem 'acts_as_votable'

# メール確認用Gem（開発環境用）
gem 'letter_opener'

# スタイリング・デザイン
gem 'bootstrap', '~> 5.3.0'
gem 'dartsass-sprockets'

# Railsフレームワーク
gem 'rails', '~> 7.0.8', '>= 7.0.8.4'

# Railsのアセットパイプライン
gem 'sprockets-rails'

# Webサーバ
gem 'puma', '~> 5.0'

# JavaScript関連
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# JSON APIを作成するためのGem
gem 'jbuilder'

# Windows環境向けのタイムゾーンデータ（Mac/Linuxでは不要）
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# アプリの起動を高速化
gem 'bootsnap', require: false

# 認証機能（ログイン/ユーザー管理）
gem 'devise'

# 開発・テスト環境用のGem
group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 5.0'
end

# 開発環境専用のGem
group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console'
end

# テスト環境専用のGem
group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
