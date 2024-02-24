class Slipvector
  class Crewmate < Record
    self.table_name = "slipvector_crewmates"

    belongs_to :surveyor, inverse_of: :crewmates
    belongs_to :survey, inverse_of: :crewmates
  end
end
