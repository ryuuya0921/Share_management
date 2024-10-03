# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    user_path(resource) # ログイン後にユーザー専用ページにリダイレクト
  end
end
