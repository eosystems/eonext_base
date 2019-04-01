class UserLoginSerializer
  include FastJsonapi::ObjectSerializer
  attributes :character_id, :name, :login_token, :created_at, :updated_at
end
