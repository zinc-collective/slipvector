class Slipvector
  class SurveyorsGuild::StarSystem::Survey::Roll
    class Shaker
      include ActiveModel::Model
      attr_accessor :rng, :dice
      def initialize(seed:, dice: [])
        self.rng = Random.new(seed)
        super(dice: dice)
      end

      def self.new_from_count(seed:, count:)
        new(dice: Dice.new(dice: (count.times.map { |index| Die.new(value: 0, index:) })), seed: seed)
      end

      def shake
        dice.each do |die|
          next if die.kept?
          die.value = rng.rand(die.sides) + 1
        end
      end
    end
  end
end
