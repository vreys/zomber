class Users::PasswordsController < Devise::PasswordsController
  layout 'light'

  def new
    @user = User.new
  end

  def edit
    @user = User.new
    @user.reset_password_token = params[:reset_password_token]
  end

  def update
    @user = User.reset_password_by_token(params[:user])

    if @user.errors.empty?
      set_flash_message :notice, :updated
      sign_in_and_redirect(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.first
      render_with_scope :edit
    end
  end
end
