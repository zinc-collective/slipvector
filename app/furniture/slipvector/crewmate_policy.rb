class Slipvector
  class CrewmatePolicy < ApplicationPolicy
    alias_method :crewmate, :object

    def create?
      person&.operator? || current_person.surveyor == crewmate.surveyor
    end

    alias_method :update?, :create?

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
