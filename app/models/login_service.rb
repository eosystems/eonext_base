class LoginService
  class LoginError < StandardError end;
  include ActiveModel::Model
  attr_accessor :access_token, :refresh_token

  def initialize(params: params)
    self.access_token = params['access_token']
    self.refresh_token = params['refresh_token']
    self.esi_client = EsiClient.new(self.access_token)
  end

  def login
    # ESIに対してユーザー情報を問い合わせる
    verify = self.fetch_verify(self.access_token)
    # ESIより返却されたキャラクターIDを元にユーザー情報を取得する
    user = User.find_by(uid: verify.CharacterID)

    if user.blank?
      # 新規
      user = User.new(
        uid: verify.CharacterID,
        name: verify.CharacterName,
      )
    end
  end

  def fetch_verify
    response = self.esi_client.fetch_verify
    if response.is_success
      response.items.first
    else
      raise LoginService::LoginError, "無効なTokenです"
    end
  end

  def fetch_character(character_id)
    response = self.esi_client.fetch_character(character_id)
    if responese.is_success
      response.items.first
    else
      raise LoginService::LoginError, 'キャラクター情報を取得できませんでした'
    end
  end

end
