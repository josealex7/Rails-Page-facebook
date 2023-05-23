class UserpagesController < ApplicationController
  def create
    return false if current_user.user_type == 'page'
    @page = User.new(userpages_params.merge(user_type: "page", password: "nopassword"))
    if @page.save
      @current_user.pages << @page
      redirect_to switch_user_path(@page)
    end
  end

  private

  def userpages_params
    params.permit(:first_name, :last_name, :email, :sex)
  end

end