class Slipvector
  class SurveyorsGuild
    class StarSystem::SurveysController < ApplicationController
      expose :star_system, scope: -> { policy_scope(StarSystem) }, model: StarSystem
      expose :surveys, -> { policy_scope(star_system.surveys) }
      expose :survey, scope: -> { surveys }, model: StarSystem::Survey

      def new
        authorize(survey)
      end

      def create
        authorize(survey)
        if survey.save
          redirect_to(survey.location)
        else
          render :new, status: :unprocessable_entity
        end
      end

      def update
        authorize(survey)
        survey.update(survey_params)
        redirect_to(survey.star_system.location)
      end

      def show
        authorize(survey)
      end

      def survey_params
        params.require(:survey).permit(:biological_dice_count, :material_dice_count, :energy_dice_count, :status)
      end
    end
  end
end
