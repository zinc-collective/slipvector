class Slipvector
  class SurveyorsGuild < Furniture
    default_scope { where(furniture_kind: :slipvector_surveyors_guild) }
    extend StripsNamespaceFromModelName

    setting :star_system_tickets

    location(parent: :room)

    has_many :surveys, inverse_of: :surveyors_guild, dependent: :destroy
    has_many :surveyors, inverse_of: :surveyors_guild, dependent: :destroy
    has_many :surveyed_star_systems, through: :surveys, class_name: :StarSystem
    has_many :star_systems, dependent: :destroy, inverse_of: :surveyors_guild


    def in_room_template
      "slipvector/in_room_template"
    end
  end
end
