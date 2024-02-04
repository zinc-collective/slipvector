class Slipvector
  class Controller < ApplicationController
    layout "slipvector"

    expose :surveyors_guild, model: SurveyorsGuild
  end
end
