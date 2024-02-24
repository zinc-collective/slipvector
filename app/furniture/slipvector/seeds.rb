space = if Space.exists?(name: "Slipvector Demo")
  Space.find_by(name: "Slipvector Demo")
else
  FactoryBot.create(:space, :with_entrance, name: "Slipvector Demo")
end

unless space.entrance.gizmos.exists?(furniture_kind: :slipvector_surveyors_guild)
  FactoryBot.create(:slipvector_surveyors_guild, room: space.entrance)
end
