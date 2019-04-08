class UsersController < BaseController
  def show
    user = User.find(params[:id])
    if user == @current_resource_owner
      serializer = UserSerializer.new(user).serialized_json
      render json: serializer
    else
      render json: { error_message: '認証エラー' }
    end
  end
end
