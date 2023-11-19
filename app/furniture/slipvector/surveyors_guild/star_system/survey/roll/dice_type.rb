class Slipvector
  class SurveyorsGuild::StarSystem::Survey::Roll
    class DiceType < ActiveRecord::Type::Json
      def deserialize(string)
        return Dice.new(dice: []) if string.nil?
        Dice.new(super)
      end

      def serialize(dice)
        if dice.is_a?(Array)
          super(Dice.new(dice: dice))
        elsif dice.is_a?(Dice)
          super(dice)
        end
      end
    end
  end
end
