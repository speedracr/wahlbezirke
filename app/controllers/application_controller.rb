class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def new_session_path(scope)
    new_user_session_path
  end

  private
    def authenticated_user?
      unless user_signed_in?
        redirect_to login_path, notice: 'Login required.'
      end
    end
end
