class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.limit(10).order(id: :desc).page(params[:page]).per(25)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザー登録をしました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end


  def destroy
    sign_out
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])


    if @user.update(user_params)
      flash[:success] = '編集しました'
      redirect_to user_path(@user.id)
    else  
      flash.now[:danger] = '編集が失敗しました'
      render :edit
    end
  end

  def add_tag
    @user = User.find(params[:id])
    @adding = @user.adding_tags
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.where.not(id: @user.followings.ids).page(params[:page])
  end

end
