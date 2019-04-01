class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless @user == @current_resource_owner
      render json: { error_message: '認証エラー' }
    end
  end
end
