space = if Space.exists?(name: "Slipvector Demo")
  Space.find_by(name: "Slipvector Demo")
else
  FactoryBot.create(:space, name: "Slipvector Demo")
end

sol_system = if space.rooms.exists?(name: "Sol System")
  space.rooms.find_by(name: "Sol System")
else
  FactoryBot.create(:room, name: "Sol System", space:)
end

space.update(entrance: sol_system)

unless space.entrance.gizmos.exists?(furniture_kind: :slipvector_surveyors_guild)
  FactoryBot.create(:slipvector_surveyors_guild, room: space.entrance)
end
