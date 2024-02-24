class Slipvector
  class Survey < Record
    self.table_name = "slipvector_surveys"

    belongs_to :star_system, inverse_of: :surveys
    belongs_to :surveyors_guild, inverse_of: :surveys
    location(parent: :surveyors_guild)

    has_many :crewmates
    has_many :surveyors, through: :crewmates

    scope :recent, -> { order(updated_at: :desc) }

    scope :seeking_crew, -> { left_outer_joins(:crewmates).preparing.having("count(survey_id) < maximum_crewmates").group("survey_id, slipvector_surveys.id") }

    enum status: {
      preparing: "preparing",
      active: "active",
      complete: "complete"
    }

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


  end
end
