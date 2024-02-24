class Slipvector
  class SurveyorsGuildPolicy < ApplicationPolicy
    alias_method :surveyors_guild, :object

    def show?
      true
    end

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
