class Slipvector
  class SurveyorsGuildsController < ApplicationController
    expose :surveyors_guild, model: SurveyorsGuild

    def show
      authorize(surveyors_guild)
    end
  end
end
