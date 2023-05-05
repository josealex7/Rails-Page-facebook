class RegistrationsController < Devise::RegistrationsController
    def update
        # Verifica si el usuario es de tipo "page"
        if current_user.user_type == "page"
          
          account_update_params.delete("current_password")
          account_update_params.delete("birthday")
          account_update_params.delete("password_confirmation")
          account_update_params.delete("password")
          result = current_user.update_without_password(account_update_params)
        else
          # Si no es un usuario de tipo "page", realiza la actualización de manera normal
          result = super
        end
    
        # Si la actualización es exitosa, redirige al usuario al perfil
        #if result
        #  redirect_to edit_user_registration_path, notice: "Tu cuenta ha sido actualizada con éxito."
        #end
      end
    
      # Métodos privados
      private
    
      def account_update_params
        # Permite los parámetros que deseas actualizar
        params.require(:user).permit(:email, :first_name, :last_name, :sex, :birthday, :password, :password_confirmation, :current_password)
      end
end
  