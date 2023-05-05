class SessionsController < Devise::SessionsController
    def new
      # Agrega tu propia lógica para la acción "new"
      super
    end
  
    def create
        user = User.find_by(email: params[:user][:email])
        
        if user && user.user_type == "page"
            puts '----------------------------------------------------------------'
            puts user
            flash.now[:alert] = "Iniciar sesión no permitido para este tipo de usuario."
            redirect_to root_path
        else
          super
        end
        
    end
  
    def destroy
      # Agrega tu propia lógica para la acción "destroy"
      super
    end
end