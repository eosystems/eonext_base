# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  uid           :string(255)      not null
#  name          :string(255)
#  sign_in_count :integer          default(0), not null
#  refresh_token :string(255)
#  expire        :datetime
#  login_token   :string(255)
#  access_token  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  has_one :user_detail

  def self.user_token(user)
    return if user.expire.nil?
    if user.user_token_expire?
      user.refresh_user_token
    else
      user.token
    end
  end

  def refresh_user_token
    response = RestClient.post "https://login.eveonline.com/oauth/token",
                               :grant_type => 'refresh_token',
                               :refresh_token => self.refresh_token,
                               :client_id => Settings.applications.app_id,
                               :client_secret => Settings.applications.app_secret

    refresh_hash = JSON.parse(response)
    self.token = refresh_hash['access_token']
    self.expire = Time.at(refresh_hash['expires_in'].to_i + Time.current.to_i)
    self.refresh_token = refresh_hash['refresh_token']

    self.save
    self.token
  end

  def user_token_expire?
    if self.expire < Time.current
      return true
    end
    false
  end
end
