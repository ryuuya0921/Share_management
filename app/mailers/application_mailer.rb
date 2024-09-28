# frozen_string_literal: true

# ApplicationMailerは、アプリケーション内でメール送信を行うための基底クラスです。
# 他のMailerクラスはこのクラスを継承し、共通の設定やヘルパーメソッドを使用します。
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
