class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.add_role(user_params)
      flash[:notice] = "User account downgraded"
      redirect_to root_path
    else
      flash[:error] = "Invalid user info"
      redirect_to root_path
    end
  end

   private

   def user_params
     params.require(:user).permit(:email, :role)
   end

end
