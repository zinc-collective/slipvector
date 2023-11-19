class Slipvector
  class SurveyorsGuild::StarSystem::Survey::RollPolicy < ApplicationPolicy
    alias_method :roll, :object

    def create?
      person&.operator? || person&.member_of?(roll.surveyors_guild.space)
    end

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
