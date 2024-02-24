class Slipvector
  class SurveyorsGuild < Furniture
    extend StripsNamespaceFromModelName

    default_scope { where(furniture_kind: :slipvector_surveyors_guild) }

    location(parent: :room)

    has_many :surveyors, inverse_of: :surveyors_guild, dependent: :destroy
    has_many :star_systems, inverse_of: :surveyors_guild, dependent: :destroy
    has_many :surveyed_star_systems, through: :surveys, class_name: :StarSystem
    has_many :surveys, inverse_of: :surveyors_guild, dependent: :destroy

    # Populates some Surveys if there are none available.
    def surveys_seeking_crew
      pull_survey until surveys.seeking_crew.length >= maximum_available_surveys
      surveys.seeking_crew
    end

    def maximum_available_surveys
      1
    end

    def pull_survey
      surveys.create(star_system: star_systems.sample || pull_star_system)
    end

    def pull_star_system
      star_systems.create
    end

    def in_room_template
      "slipvector/in_room_template"
    end
  end
end
