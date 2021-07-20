class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def edit
 
  end
 
  def update
    current_user.assign_attributes(account_update_params)
    if current_user.save
	  redirect_to my_page_path, notice: 'プロフィールを更新しました'
    else
      render "profile_edit"
    end
  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[avatar nickname age sex_id prefecture_id gymnasium ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[avatar nickname age sex_id prefecture_id gymnasium ])
   end

   def require_user_signed_in
    unless user_signed_in?
      redirect_to login_url
    end
  end

end
