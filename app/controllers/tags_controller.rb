class TagsController < ApplicationController
  before_action :require_user_signed_in, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    @tag = current_user.tags.build if user_signed_in?
    @tags = Tag.search(params[:search]).order(created_at: :desc).page(params[:page]).per(25)
  end

  def show
    @chat_message = ChatMessage.new
    @tag = Tag.find(params[:id])
    @users = @tag.added_user.page(params[:page]).per(25)
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      flash[:success] = 'チャットルームを作成しました！'
      redirect_to tag_chat_messages_path(@tag)
    else
      @tags = Tag.all.order(created_at: :desc).page(params[:page]).per(25)
      flash.now[:danger] = '作成に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @tag.destroy
    flash[:success] = '投稿を削除しました'
    tag = Tag.find(params[:id])
    redirect_to tags_path
  end

 
  
  private
  
    def tag_params
      params.require(:tag).permit(:title, :content, :image)
    end
    
    def correct_user
      @tag = current_user.tags.find_by(id: params[:id])
      unless @tag
        redirect_to root_url
      end
    end
end
