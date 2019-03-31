class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user == @current_resource_owner
      render json: @user
    else
      render json: { error_message: '認証エラー' }
    end
  end
end