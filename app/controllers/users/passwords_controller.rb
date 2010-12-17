class Users::PasswordsController < Devise::PasswordsController
  layout 'light'

  def new
    @user = User.new
  end

  def create
    @user = User.send_reset_password_instructions(params[:user])

    if @user.errors.empty?
      set_flash_message :notice, :send_instructions
      redirect_to new_session_path(resource_name)
    else
      flash.now[:alert] = @user.errors.full_messages.first
      render_with_scope :new
    end
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
