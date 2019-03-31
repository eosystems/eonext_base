class EsiClient
  EVE_LOGIN_BASE_URL = 'https://login.eveonline.com'.freeze
  ESI_API_BASE_URL = ENV['EVEONLINE_ESI_BASE'].freeze

  def initialize(token)
    @token = token
  end

  def fetch_verify
    path = EVE_LOGIN_BASE_URL + "/oauth/verify"
    Rails.logger.info("ESIClient Access to #{path}")

    GeneralEsiResponse.parse_simple(get_request_to(path))
  end

  def fetch_character(character_id)
    path = ESI_API_BASE_URL + "/characters/#{character_id}/"
    Rails.logger.info("ESIClient Access to #{path}")

    GeneralEsiResponse.parse_simple(get_request_to(path))
  end

  def fetch_character_roles(character_id)
    path = ESI_API_BASE_URL + "/characters/#{character_id}/roles/"
    Rails.logger.info("ESIClient Access to #{path}")

    GeneralEsiResponse.parse_simple_array(get_request_to(path))
  end

  def fetch_character_corporation_history(character_id)
    path = ESI_API_BASE_URL + "/characters/#{character_id}/corporationhistory/"
    Rails.logger.info("ESIClient Access to #{path}")

    GeneralEsiResponse.parse_simple_array(get_request_to(path))
  end

  def fetch_corporation(corporation_id)
    path = "#{ESI_API_BASE_URL}/corporations/#{corporation_id}"
    Rails.logger.info("ESIClient Access to #{path}")
    GeneralEsiResponse.parse_simple(get_request_to(path))
  end

  private

  def build_api_connection
    Faraday.new(url: ESI_API_BASE_URL) do |builder|
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end
  end

  def get_request_to(path)
    conn = build_api_connection
    conn.get do |req|
      req.url path
      req.headers['Authorization'] = "Bearer #{@token}"
    end
  end

end
