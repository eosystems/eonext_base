# == Schema Information
#
# Table name: assets
#
#  id            :integer          not null, primary key
#  is_singleton  :boolean
#  item_id       :integer
#  location_flag :string(255)
#  location_id   :integer
#  location_type :string(255)
#  quantity      :integer
#  type_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Asset < ActiveRecord::Base
  def fetch
    user = User.find(1)
    esi_client = EsiClient.new(user.access_token)
    r = esi_client.fetch_character_assets(user.character_id)
    Asset.where(user_id: user.id).delete_all
    r.items.each do |item|
      asset = Asset.new

      asset.attributes = {
        user_id: user.id,
        is_singleton: item["is_singleton"],
        item_id: item['item_id'],
        location_flag: item['location_flag'],
        location_id: item['location_id'],
        location_type: item['location_type'],
        quantity: item['quantity'],
        type_id: item['type_id'],
      }
      asset.save!
    end
  end
end
