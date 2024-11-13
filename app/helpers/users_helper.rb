module UsersHelper
  def follow_button(user)
    return if user == current_user # 自分自身の場合はボタンを表示しない

    if current_user.following.include?(user)
      button_to 'フォロー解除', unfollow_user_path(user), method: :delete, class: 'btn btn-danger'
    else
      button_to 'フォロー', follow_user_path(user), method: :post, class: 'btn btn-primary'
    end
  end
end
