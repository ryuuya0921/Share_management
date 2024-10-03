module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: :destroy

    def ensure_normal_user
      return unless resource.email == 'guest@example.com'

      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end
end
