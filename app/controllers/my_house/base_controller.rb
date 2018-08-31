class MyHouse::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'my_house/layouts/my_house'

  include Signable::UserSession

  before_filter :auth_user

  private

    def auth_user
      unless logged_in?
        flash[:notice] = "登录"
        redirect_to new_my_house_session_path
      end
    end
end
