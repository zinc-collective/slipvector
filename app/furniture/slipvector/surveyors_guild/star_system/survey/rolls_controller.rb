class Slipvector
  class SurveyorsGuild::StarSystem
    class Survey::RollsController < ApplicationController
      expose :survey, scope: -> { policy_scope(Survey) }, model: Survey
      expose :roll, scope: -> { policy_scope(survey.rolls) }, model: Survey::Roll
      def create
        roll = survey.rolls.next(roll_params.to_h.with_indifferent_access)
        authorize(roll)
        if roll.save
          redirect_to(roll.survey.location, notice: t(".success"))
        else
          redirect_to(roll.survey.location, error: t(".failure"))
        end
      end

      def roll_params
        params.require(:roll)
          .permit(energy_dice_kept: [], life_dice_kept: [], material_dice_kept: [], oddity_dice_kept: []).tap do |result|
            ["energy_dice_kept", "life_dice_kept", "material_dice_kept", "oddity_dice_kept"].each do |attribute|
              result[attribute].compact_blank!.map!(&:to_i)
            end
          end
      end
    end
  end
end
