class Slipvector
  class SurveyPolicy < ApplicationPolicy
    alias_method :survey, :object

    def create?
      person&.operator? || person&.member_of?(survey.star_system.surveyors_guild.space)
    end

    alias_method :update?, :create?

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
