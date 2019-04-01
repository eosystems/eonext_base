class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :character_id, :name, :is_main
end
