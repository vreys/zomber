class Users::InvitationsController < Devise::InvitationsController
  def edit
    @user = User.find_by_invitation_token(params[:invitation_token])
  end

  def update
    @user = User.accept_invitation!(params[resource_name])

    if @user.errors.empty?
      set_flash_message :notice, :updated
      sign_in_and_redirect(@user)
    else
      flash[:alert] = @user.errors.full_messages.first

      render :edit
    end
  end
end
