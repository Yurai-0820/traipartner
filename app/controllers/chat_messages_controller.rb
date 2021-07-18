class ChatMessagesController < ApplicationController
  def index

    @chat_message = ChatMessage.new
    @tag = Tag.find(params[:tag_id])
    @tag = current_user.tags.build if user_signed_in?
    @tags = Tag.search(params[:search]).order(created_at: :desc).page(params[:page]).per(25)
    @users = @tag.added_user.page(params[:page]).per(25)
    @chat_messages = @tag.chat_messages.includes(:user)
  end

  

  def create
    @tag = Tag.find(params[:tag_id])
    @chat_message = @tag.chat_messages.new(chat_message_params)
    if @chat_message.save
      redirect_to tag_chat_messages_path(@tag)
    else
      @chat_messages = @tag.chat_messages.includes(:user)
      render :index
    end
  end

 
  def destroy
    @tag.destroy
    flash[:success] = '投稿を削除しました'
    tag = Tag.find(params[:id])
    redirect_to tags_path
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:content).merge(user_id: current_user.id)
  end



end


