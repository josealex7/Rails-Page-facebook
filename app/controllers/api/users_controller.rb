require 'securerandom'

class Api::UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:token]

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      sign_in(user)
      render json: user
    else
      render json: { error: 'Correo o contraseña incorrectos.' }, status: :not_found
    end
  end

  def show
    if (current_user.id).to_s == params[:id]
      render json: current_user
    else
      render json: { error: 'No tienes permitido obtener esta información.' }, status: :not_found
    end 
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def csrf_token
    session[:_csrf_token]
  end

  def update
    if current_user.id.to_s == params[:id]
      # user = User.find(params[:id])
  
      # if params[:first_name].present?
      #   user.first_name = params[:first_name]
      # end
  
      # if params[:last_name].present?
      #   user.last_name = params[:last_name]
      # end
  
      # if user.save
      #   render json: user, status: :ok
      # else
        render json: { error: 'No se pudo actualizar el usuario' }, status: :unprocessable_entity
      # end
    else
      render json: { error: 'No tienes permitido realizar esa acción.' }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end