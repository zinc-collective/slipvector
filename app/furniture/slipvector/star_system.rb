class Slipvector
  class StarSystem < Record
    self.table_name = "slipvector_star_systems"

    belongs_to :surveyors_guild, inverse_of: :star_systems
    location(parent: :surveyors_guild)

    attribute :data_levels, DataLevelType.new

    has_many :surveys, inverse_of: :star_system, dependent: :destroy
    has_many :active_surveys, -> { active }, class_name: :Survey

    def name
      super.presence || id
    end
  end
end
