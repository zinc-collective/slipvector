class Slipvector
  class Surveyor < Record
    self.table_name = "slipvector_surveyors"

    belongs_to :surveyors_guild, inverse_of: :surveyors
    location(parent: :surveyors_guild)
  end
end
