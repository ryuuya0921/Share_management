module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: [:destroy, :update]

    def ensure_normal_user
      return unless resource.email == 'guest@example.com'

      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行うことができません。' and return
    end

    def update
      ensure_normal_user
      super
    end
  end
end
