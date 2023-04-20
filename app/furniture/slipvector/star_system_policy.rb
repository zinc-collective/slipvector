class Slipvector
  class StarSystemPolicy < ApplicationPolicy
    def create?
      person&.operator? || person&.member_of?(current_space)
    end
  end
end
