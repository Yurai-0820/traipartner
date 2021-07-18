class TagRelationsController < ApplicationController
  before_action :require_user_signed_in
  
  def create
    tag = Tag.find(params[:tag_id])
    current_user.adding(tag)
    flash[:success] = 'チャットルームを作成しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tag = Tag.find(params[:tag_id])
    current_user.remove(tag)
    flash[:success] = 'チャットルームから退出しました'
    redirect_back(fallback_location: root_path)
  end
end
