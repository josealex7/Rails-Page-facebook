class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_last_messages

    def set_last_messages
        @last_messages = {}
        if current_user
          friends = current_user.friends
          friends.each do |friend|
            last_message = Message.where(sender: current_user, receiver: friend)
                                   .or(Message.where(sender: friend, receiver: current_user))
                                   .order(created_at: :desc)
                                   .first
            @last_messages[friend.id] = last_message
          end
        end
    end


    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:sex, :birthday, :first_name, :last_name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:sex, :birthday, :first_name, :last_name])
    end

    def upload_image_to_cloudinary
      tempfile = params[:image][:url].tempfile
      Cloudinary::Uploader.upload(tempfile.path)['secure_url']
    end

end
