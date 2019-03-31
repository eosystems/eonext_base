class LoginController < ApiController
  def create
    access_token = params[:access_token]
    # ESIに対してユーザー情報を問い合わせる

    # ESIより返却されたキャラクターIDを元にユーザー情報を取得する
  end
end
