class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(current_user.id)
  end

  def downgrade
    @user = current_user
    @user.downgrade
    flash[:notice] = "You now have standard access."
    redirect_to profile_path
  end

   private

   def user_params
     params.require(:user).permit(:email, :role)
   end

   def publicize_wikis
     current_user.wikis.each do |wiki|
       wiki.update_attribute(:collaborations, [wiki.collaborations.first]) # goes back to original user
       wiki.update_attribute(:private, false)
     end
   end
end
