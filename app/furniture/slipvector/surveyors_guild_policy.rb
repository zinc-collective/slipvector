class Slipvector
  class SurveyorsGuildPolicy < ApplicationPolicy
    alias_method :surveyors_guild, :object

    def show?
      person&.operator? || person&.member_of?(surveyors_guild.space)
    end

    class Scope < ApplicationScope
      def resolve
        scope.all
      end
    end
  end
end
