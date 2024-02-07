class Slipvector
  class StarSystem::Experience
    include StoreModel::Model

    attribute :energy, :integer, default: 0
    attribute :energy_level, :integer, default: 1
    attribute :life, :integer, default: 0
    attribute :life_level, :integer, default: 1
    attribute :matter, :integer, default: 0
    attribute :matter_level, :integer, default: 1
    attribute :oddities, :integer, default: 0
    attribute :oddities_level, :integer, default: 1

    def bump(result)
      assign_attributes({result.elmo => attribute(result.elmo) + result.xp})
    end

    def pools
      @experience ||= [
        Level.new(elmo: :energy, xp: energy, level: energy_level),
        Level.new(elmo: :life, xp: life, level: life_level),
        Level.new(elmo: :matter, xp: matter, level: matter_level),
        Level.new(elmo: :oddities, xp: oddities, level: oddities_level)
      ]
    end

    class Level < DataLevel
      attribute :level, :integer, default: 0

      def next_level_xp
        level * 125
      end

      def ready_for_level_up?
        xp > next_level_xp
      end

    end
  end
end
