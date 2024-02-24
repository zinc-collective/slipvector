class Slipvector
  class CrewmatesController < Controller
    expose :crewmate, scope: -> { policy_scope(survey.crewmates) }, model: Crewmate,
      build: ->(params, scope) { scope.new(params.merge(surveyor: current_surveyor)) }
    expose :survey, scope: -> { policy_scope(surveyors_guild.surveys.seeking_crew) }, model: Survey

    def new
      authorize(crewmate)
    end

    def create
      authorize(crewmate)
      if crewmate.save
        redirect_to survey.location, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end
  end
end
