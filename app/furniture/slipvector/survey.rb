class Slipvector
  class Survey < Record
    self.table_name = "slipvector_surveys"

    belongs_to :star_system, inverse_of: :surveys
    location(parent: :star_system)
    has_one :surveyors_guild, through: :star_system

    scope :recent, -> { order(updated_at: :desc) }

    after_commit :update_star_system

    def update_star_system
      if status_previously_changed?(to: "complete")
        results.each do |data_level|
          star_system.experience.bump(data_level)
        end
        star_system.save
      end
    end

    def name
      "Survey #{id.slice(-6,6)}"
    end

    def results
      rng = Random.new(id.hash)

      rng.rand(6).times.map do
        elmo = ELMOS.keys.sample(random: rng)
        DataLevel.new(elmo:, xp: rng.rand(3).times.sum { rng.rand(20) })
      end
    end

    enum status: {
      preparing: "preparing",
      active: "active",
      complete: "complete"
    }
  end
end
