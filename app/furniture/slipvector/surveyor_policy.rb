class Slipvector
  class SurveyorPolicy < ApplicationPolicy
    alias_method :surveyor, :object

    def create?
      true
    end

    def update?
      surveyor == current_person.surveyor || current_person.operator?
    end

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
