class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin_user! #use predefined method name
    if !user_signed_in?
       redirect_to "users/sign_in", alert: "Please sign in to use the database"
    end
    authenticate_user! 
  end 

  def current_admin_user #use predefined method name
    return nil if user_signed_in? && !current_user.has_role?(:admin)
    current_user 
  end
      
end
