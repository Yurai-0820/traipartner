class ToppagesController < ApplicationController
  def index
    @user = User.all
      # if user_signed_in?
      #   @users = current_user.followings & current_user.followers
      # end
  end

  def contact
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

    private

    def user_params
      params.require(:user).permit(:nickname, :email, :password, :age, :sex_id, :prefecture_id, :gymnasium)
    end

end
