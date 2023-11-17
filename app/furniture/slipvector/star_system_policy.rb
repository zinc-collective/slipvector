class Slipvector
  class StarSystemPolicy < ApplicationPolicy
    alias_method :star_system, :object

    def create?
      person&.operator? || person&.member_of?(star_system.surveyors_guild.space)
    end
  end
end
