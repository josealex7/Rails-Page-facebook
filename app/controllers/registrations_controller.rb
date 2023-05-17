class RegistrationsController < Devise::RegistrationsController
  def update
    if current_user.user_type == "page"
      account_update_params.delete("current_password")
      account_update_params.delete("birthday")
      account_update_params.delete("password_confirmation")
      account_update_params.delete("password")
      result = current_user.update_without_password(account_update_params)
    else
      result = super
    end
  end

  private

  def account_update_params
    params.require(:user).permit(:email, :first_name, :last_name, :sex, :birthday, :password, :password_confirmation, :current_password)
  end
end
  