class Slipvector
  class SurveyorsGuildsController < Controller
    def show
      authorize(surveyors_guild)
    end
  end
end
