class LoginService
  class LoginError < StandardError; end

  include ActiveModel::Model
  attr_accessor :access_token, :refresh_token, :esi_client

  def initialize(params: {})
    self.access_token = params[:access_token]
    self.refresh_token = params[:refresh_token]
    self.esi_client = EsiClient.new(self.access_token)
  end

  def login
    # ESIに対してユーザー情報を問い合わせる
    verify = self.fetch_verify
    # ESIより返却されたキャラクターIDを元にユーザー情報を取得する
    user = User.find_by(character_id: verify.CharacterID)

    if user.blank?
      # 新規
      user = User.new(
        character_id: verify.CharacterID,
        name: verify.CharacterName,
        is_main: nil,
        sign_in_count: 0,
      )
    end

    character_info = self.fetch_character(user.character_id)
    user.attributes = {
      corporation_id: character_info.corporation_id,
      login_token: SecureRandom.hex(32),
      access_token: self.access_token,
      refresh_token: self.refresh_token,
      expire: verify.ExpiresOn,
      sign_in_count: user.sign_in_count + 1,
    }

    # 存在しないコープの場合は新規に作成する
    corporation_id = character_info.corporation_id
    if Corporation.find_by(corporation_id: corporation_id).blank?
      corporation_info = self.fetch_corporation(corporation_id)
      corporation = Corporation.new(
        corporation_id: character_info.corporation_id,
        corporation_name: corporation_info.name,
      )
      corporation.save!
    end

    user.save!
    user
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
    if response.is_success
      response.items.first
    else
      raise LoginService::LoginError, 'キャラクター情報を取得できませんでした'
    end
  end

  def fetch_corporation(corporation_id)
    response = self.esi_client.fetch_corporation(corporation_id)
    if response.is_success
      response.items.first
    else
      raise LoginService::LoginError, 'コープ情報を取得できませんでした'
    end
  end

end
