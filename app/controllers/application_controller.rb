class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

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
