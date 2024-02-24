class Slipvector
  class Surveyor < Record
    self.table_name = "slipvector_surveyors"

    belongs_to :surveyors_guild, inverse_of: :surveyors
    location(parent: :surveyors_guild)

    has_many :crewmates, dependent: :destroy
    has_many :surveys, through: :crewmates
  end
end
