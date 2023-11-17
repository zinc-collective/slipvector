class Slipvector
  class SurveyorsGuild
    class StarSystemsController < ApplicationController
      def create
        star_system = surveyors_guild.star_systems.new
        authorize(star_system)
        if star_system.save
          redirect_to(star_system.surveyors_guild.location, notice: t(".success"))
        else
          redirect_to(star_system.surveyors_guild.location, error: t(".failure"))
        end
      end

      def surveyors_guild
        SurveyorsGuild.find(params[:surveyors_guild_id])
      end
    end
  end
end
