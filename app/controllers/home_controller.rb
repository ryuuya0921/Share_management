class HomeController < ApplicationController
  def index
    @message = if user_signed_in?
                 "ようこそ、#{current_user.email}さん。"
               else
                 'ログインしてください'
               end
  end
end
