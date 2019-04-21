# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  character_id      :string(255)
#  name              :string(255)
#  corporation_id    :integer
#  alliance_id       :integer
#  is_main           :boolean
#  main_character_id :integer
#  sign_in_count     :integer          default(0), not null
#  login_token       :string(255)
#  access_token      :string(255)
#  refresh_token     :text(65535)
#  expire            :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :character_id, :name, :is_main
end
