class Slipvector
  class SurveyorsGuild::StarSystem::Survey::Roll < Record
    self.table_name = "slipvector_survey_rolls"
    belongs_to :survey
    location(parent: :survey)
    belongs_to :preceding_roll, inverse_of: :succeeding_roll, class_name: "Roll", optional: true
    has_one :succeeding_roll, inverse_of: :preceding_roll, foreign_key: :preceding_roll, class_name: "Roll"

    attribute :energy_dice, DiceType.new
    delegate :score, :count, :kept, :kept=, to: :energy_dice, prefix: true
    alias_method :energy_data, :energy_dice_score

    attribute :life_dice, DiceType.new
    delegate :score, :count, :kept, :kept=, to: :life_dice, prefix: true
    alias_method :life_data, :life_dice_score

    attribute :material_dice, DiceType.new
    delegate :score, :count, :kept, :kept=, to: :material_dice, prefix: true
    alias_method :material_data, :material_dice_score

    attribute :oddity_dice, DiceType.new
    delegate :score, :count, :kept, :kept=, to: :oddity_dice, prefix: true
    alias_method :oddity_data, :oddity_dice_score

    scope :by_turn, -> { order(turn: :asc) }

    def total_score
      dice_score * bonus
    end

    def dice_score
      (energy_data + life_data + material_data + oddity_data)
    end

    def bonus
      set_bonus * roll_bonus
    end

    def efficiency
      total_score / (turn * all_dice.length)
    end

    def roll_bonus
      case turn
      when 1..2
        4
      when 3..4
        2
      else
        1
      end
    end

    def set_bonus
      sets = all_dice.group_by(&:value)
      case sets
      when 1
        3
      when 2
        2
      else
        1
      end
    end

    def all_dice
      energy_dice + life_dice + material_dice + oddity_dice
    end

    def self.next(attributes)
      return create_first! if blank?

      last_roll = by_turn.last
      last_roll.energy_dice_kept = attributes[:energy_dice_kept]
      last_roll.life_dice_kept = attributes[:life_dice_kept]
      last_roll.material_dice_kept = attributes[:material_dice_kept]
      last_roll.oddity_dice_kept = attributes[:oddity_dice_kept]

      seed = last_roll.id.hash

      new(turn: last_roll.turn + 1, preceding_roll: last_roll,
        energy_dice: Shaker.new(seed: seed + 1, dice: last_roll.energy_dice).shake,
        life_dice: Shaker.new(seed: seed + 2, dice: last_roll.life_dice).shake,
        material_dice: Shaker.new(seed: seed + 3, dice: last_roll.material_dice).shake,
        oddity_dice: Shaker.new(seed: seed + 4, dice: last_roll.oddity_dice).shake)
    end

    def self.create_first!(seed:, energy_dice_count:, life_dice_count:, material_dice_count:, oddity_dice_count:)
      create!(turn: 1,
        energy_dice: Shaker.new_from_count(seed: seed + 1, count: energy_dice_count).shake,
        life_dice: Shaker.new_from_count(seed: seed + 2, count: life_dice_count).shake,
        material_dice: Shaker.new_from_count(seed: seed + 3, count: material_dice_count).shake,
        oddity_dice: Shaker.new_from_count(seed: seed + 4, count: oddity_dice_count).shake)
    end
  end
end
