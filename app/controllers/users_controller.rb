class UsersController < ApplicationController
    
    def my_friends
        @friends = current_user.friends
      end

    def fotos
        @user = User.find(params[:id])
        @imagenes = @user.images
        render 'profile/fotos'
    end

    def friends
        @user = User.find(params[:id])
        @imagenes = @user.images
        render 'profile/friends'
    end
    
    def show
        @user = User.find(params[:id])
        @imagenes = @user.images
      end

    def search
        if params[:friend].present?
            @friends = User.search(params[:friend])
            @friends = current_user.except_current_user(@friends)
            if @friends
            respond_to do |format|
                format.js { render partial: 'users/friend_result', locals: { friends: @friends } }
            end
            else
            respond_to do |format|
                flash.now[:alert] = "Couldn't find user"
                format.js { render partial: 'users/friend_result' }
            end
            end    
        else
            respond_to do |format|
            flash.now[:alert] = "Please enter a friend name or email to search"
            format.js { render partial: 'users/friend_result' }
            end
        end
    end

    def update_image_portada
        portada = params[:portada_picture_id]
        if !portada.blank?
            current_user.update(image_portada_id: portada)
            redirect_to user_path(current_user)
        end
    end

    def update_image_profile
        profile = params[:portada_picture_id]
        if !profile.blank?
            current_user.update(image_profile_id: profile)
            redirect_to user_path(current_user)
        end
    end
    

end