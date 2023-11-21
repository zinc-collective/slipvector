class Slipvector
  class SurveyorsGuild
    class StarSystem < Record
      self.table_name = "slipvector_star_systems"

      belongs_to :surveyors_guild, inverse_of: :star_systems
      location(parent: :surveyors_guild)

      has_many :surveys, inverse_of: :star_system, dependent: :destroy

      def energy_data
        surveys.complete.sum(:energy_data)
      end

      def life_data
        surveys.complete.sum(:life_data)
      end

      def material_data
        surveys.complete.sum(:material_data)
      end

      def oddity_data
        surveys.complete.sum(:oddity_data)
      end
    end
  end
end
