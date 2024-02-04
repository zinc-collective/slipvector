class Slipvector
  class Survey < Record
    self.table_name = "slipvector_surveys"

    belongs_to :star_system, inverse_of: :surveys
    location(parent: :star_system)
    has_one :surveyors_guild, through: :star_system

    scope :recent, -> { order(updated_at: :desc) }

    enum status: {
      preparing: "preparing",
      active: "active",
      complete: "complete"
    }
  end
end
