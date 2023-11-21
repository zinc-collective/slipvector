class Slipvector
  class SurveyorsGuild::StarSystem::Survey < Record
    self.table_name = "slipvector_surveys"

    belongs_to :star_system, inverse_of: :surveys
    location(parent: :star_system)
    has_one :surveyors_guild, through: :star_system

    has_many :rolls, inverse_of: :survey, dependent: :destroy

    attribute :energy_data, :integer, default: 0
    attribute :energy_dice_count, :integer, default: 0
    validates :energy_dice_count, numericality: {only_integer: true, in: (0..6)}

    attribute :life_data, :integer, default: 0
    attribute :life_dice_count, :integer, default: 0
    validates :life_dice_count, numericality: {only_integer: true, in: (0..6)}

    attribute :material_data, :integer, default: 0
    attribute :material_dice_count, :integer, default: 0
    validates :material_dice_count, numericality: {only_integer: true, in: (0..6)}

    attribute :oddity_data, :integer, default: 0
    attribute :oddity_dice_count, :integer, default: 0
    validates :oddity_dice_count, numericality: {only_integer: true, in: (0..6)}

    after_create :create_first_roll

    before_validation :cache_results, if: -> { will_save_change_to_attribute?(:status, from: :in_progress, to: :complete) }

    enum status: {
      preparing: "preparing",
      in_progress: "in_progress",
      complete: "complete"
    }

    def create_first_roll
      rolls.create_first!(seed: id.hash, energy_dice_count:, life_dice_count:, material_dice_count:, oddity_dice_count:) if rolls.empty?
    end

    def cache_results
      self.energy_data = last_roll.energy_data
      self.life_data = last_roll.life_data
      self.material_data = last_roll.material_data
      self.oddity_data = last_roll.oddity_data
      self.efficiency = last_roll.efficiency
      self.score = last_roll.total_score
    end

    def last_roll
      @last_roll ||= rolls.by_turn.last
    end

    def next_roll
      return create_first_roll if rolls.empty?

      rolls.new(turn: last_roll.turn + 1,
        preceding_roll: last_roll,
        energy_dice: last_roll.energy_dice,
        life_dice: last_roll.life_dice,
        material_dice: last_roll.material_dice,
        oddity_dice: last_roll.oddity_dice)
    end
  end
end
