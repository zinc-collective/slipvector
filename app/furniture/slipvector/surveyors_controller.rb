class Slipvector
  class SurveyorsController < Controller
    expose :surveyor, scope: -> { surveyors_guild.surveyors }, model: Surveyor
    def new
      authorize(surveyor)
    end

    def create
      authorize(surveyor)
      if surveyor.save
        self.current_surveyor = surveyor
        redirect_to surveyor.location, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      authorize(surveyor)
    end

    def surveyor_params
      params.require(:surveyor).permit(:name)
    end
  end
end
