class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else 
      render json: { status: :unprocessable_entity }
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  private :user_params
end