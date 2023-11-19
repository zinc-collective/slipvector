class Slipvector
  class SurveyorsGuild::StarSystem::Survey::Roll
    class Dice
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :kept, array: true, skidefault: -> { [] }
      attribute :dice, DieType.new, array: true, default: -> { [] }

      delegate :[], :length, :map, :each, :reduce, :group_by, to: :dice
      alias_method :count, :length

      def score
        return 0 if length.zero?
        base_score * set_bonus
      end

      def kept
        dice.select(&:kept?).map(&:index)
      end

      def kept=(indexes)
        return if indexes.nil?
        dice.each do |dice|
          indexes.include?(dice.index) ? dice.keep! : dice.leave!
        end

        kept
      end

      def base_score
        @base_score ||= grouped_dice.reduce(0) do |result, (value, dice)|
          result + (value * dice.length)
        end
      end

      def set_bonus
        @set_bonus ||= case grouped_dice.length
        when 1
          3
        when 2
          2
        else
          1
        end
      end

      def grouped_dice
        @grouped_dice ||= group_by(&:value)
      end

      def +(other)
        Dice.new(dice: (dice + other.dice))
      end
    end
  end
end
