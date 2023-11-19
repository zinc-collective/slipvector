class Slipvector
  class SurveyorsGuild
    class StarSystemPolicy < ApplicationPolicy
      alias_method :star_system, :object

      def create?
        person&.operator? || person&.member_of?(star_system.surveyors_guild.space)
      end

      alias_method :update?, :create?

      class Scope < ApplicationScope
        def resolve
          scope.all
        end
      end
    end
  end
end
