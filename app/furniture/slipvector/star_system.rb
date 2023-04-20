class Slipvector
  class StarSystem < ApplicationRecord
    extend StripsNamespaceFromModelName

    self.table_name = "slipvector_star_systems"
    has_many :surveys, inverse_of: :star_system, dependent: :destroy

    belongs_to :surveyors_guild, inverse_of: :star_systems

    attribute :science_xp, XpType.new
    attribute :materials_xp, XpType.new
    attribute :energy_xp, XpType.new
  end
end
