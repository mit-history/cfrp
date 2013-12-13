class ApplicationController < ActionController::Base
  protect_from_forgery

  # use predefined method name
  def authenticate_admin_user!
    if !user_signed_in?
       redirect_to "/users/sign_in", alert: "Please sign in to use the database"
    end
    authenticate_user! 
  end 

  def current_admin_user #use predefined method name
    if user_signed_in? && !current_user.has_role?(:admin)
      return nil
    end
    current_user 
  end

  def access_denied(exception)
    redirect_to root_path, :alert => exception.message
  end

end
