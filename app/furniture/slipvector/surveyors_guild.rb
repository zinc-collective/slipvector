class Slipvector
  class SurveyorsGuild < Furniture
    default_scope { where(furniture_kind: :slipvector_surveyors_guild) }
    extend StripsNamespaceFromModelName

    location(parent: :room)

    has_many :surveys, inverse_of: :surveyors_guild, dependent: :destroy
    has_many :surveyed_star_systems, through: :surveys, class_name: :StarSystem
    has_many :star_systems, dependent: :destroy, inverse_of: :surveyors_guild
  end
end
