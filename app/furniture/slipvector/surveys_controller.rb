class Slipvector
  class SurveysController < Controller
    expose :surveyor, scope: -> { policy_scope(Surveyor) }, model: Surveyor
    expose :surveys, -> { policy_scope(surveyor.surveys) }

    expose :survey, scope: -> { surveys }, model: Survey,
      build: ->(params, scope) { scope.new(params.merge(surveyors: [surveyor])) }

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
      params.require(:survey).permit(:status)
    end
  end
end
