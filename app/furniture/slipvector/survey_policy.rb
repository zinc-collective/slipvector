class Slipvector
  class SurveyPolicy < ApplicationPolicy
    alias_method :survey, :object

    def create?
      person&.operator? || survey.surveyors.include?(current_person.surveyor)
    end

    alias_method :update?, :create?

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
