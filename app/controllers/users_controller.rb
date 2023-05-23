class UsersController < ApplicationController
  layout 'profile'
  
  before_action :show_images_user, only: [:fotos, :friends, :pages, :show, :shops]

  def fotos
  end

  def friends
  end

  def pages

  end

  def shops
    @shops = Stripe::PaymentIntent.list(
      customer: @user.customer.stripe_customer_id
    ).data.select do |shop|
      shop['amount_received'] != '0' && shop['amount_received'] != 0
    end
    
    puts 'aqui esta el shops'
    puts @shops
  end
    
  def show
    @publications = @user.publications.order(created_at: :desc)
  end

  def switch_user
    user = User.find(params[:id])
    if userpages_exists?(current_user.id, user.id)
      sign_in(user, bypass: true)
      redirect_to root_path
    else
      redirect_to root_path
    end
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
    if portada.present?
        current_user.update(image_portada_id: portada)
    end
    redirect_to user_path(current_user)
  end

  def update_image_profile
    profile = params[:portada_picture_id]
    if profile.present?
        current_user.update(image_profile_id: profile)
    end
    redirect_to user_path(current_user)
  end

  private

  def show_images_user
    @user = User.find(params[:id])
    @imagenes = @user.images
  end

  def userpages_exists?(user_id, userpage_id)
    Userpage.exists?(user_id: user_id, userpage_id: userpage_id) ||
    Userpage.exists?(user_id: userpage_id, userpage_id: user_id)
  end

end