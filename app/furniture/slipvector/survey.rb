class Slipvector
  class Survey < ApplicationRecord
    self.table_name = "slipvector_surveys"

    belongs_to :surveyors_guild, inverse_of: :surveys
    belongs_to :star_system, inverse_of: :surveys

    attribute :science_xp, XpType.new
    attribute :materials_xp, XpType.new
    attribute :energy_xp, XpType.new
  end
end
