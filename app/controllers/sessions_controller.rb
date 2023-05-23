class SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.user_type == "page"
        flash.now[:alert] = "Iniciar sesión no permitido para este tipo de usuario."
        redirect_to root_path
    else
      super
    end 
  end
end