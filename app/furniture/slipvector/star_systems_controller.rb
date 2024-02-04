class Slipvector
  class StarSystemsController < Controller
    expose :star_system, scope: -> { surveyors_guild.star_systems }, model: StarSystem

    def new
      authorize(star_system)
    end

    def create
      authorize(star_system)
      if star_system.save
        redirect_to(star_system.surveyors_guild.location, notice: t(".success"))
      else
        redirect_to(star_system.surveyors_guild.location, error: t(".failure"))
      end
    end

    def show
      authorize(star_system)
    end
  end
end
