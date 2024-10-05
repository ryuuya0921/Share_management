module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: [:destroy, :update]

    def ensure_normal_user
      return unless resource.email == 'guest@example.com'

      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行うことができません。' and return
    end

    protected

    def update_resource(resource, params)
      if params[:password].blank? && params[:password_confirmation].blank? && params[:current_password].blank?
        resource.update_without_password(params.except(:password, :password_confirmation, :current_password))
      else
        super
      end
    end

    def after_update_path_for(resource)
      user_path(resource)
    end
  end
end
