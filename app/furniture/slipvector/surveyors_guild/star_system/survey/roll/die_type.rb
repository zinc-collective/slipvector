class Slipvector
  class SurveyorsGuild::StarSystem::Survey::Roll
    class DieType < ActiveRecord::Type::Json
      def deserialize(string)
        return nil if string.nil?
        super.map do |die|
          Die.new(**die)
        end
      end

      def serialize(die)
        super
      end
    end
  end
end
