class MyHouse::SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new

  end

  def create
    @user = User.authenticate(params[:username], params[:password])
    if @user 
      signin_user @user
      render json: {
        status: 'ok',
        msg: {
          redirect_url: my_house_root_path
        }
      }
    else
      render json: {
        status: 'error',
        msg: "用户名或密码不正确"
      }
    end
  end

  def destroy
    logout_user
    flash[:notice] =  "退出成功"
    redirect_to root_path
  end
end
