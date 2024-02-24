class Slipvector
  class SurveyorsGuild
    class Routes
      def self.append_routes(router)
        router.resources(:surveyors_guilds, only: [:show], module: "slipvector") do
          router.resources(:surveyors, only: [:new, :create, :show])
          router.resources(:surveys, only: []) do
            router.resources(:crewmates, only: [:new])
          end
          router.resources(:star_systems, only: [:new, :create, :show]) do
            router.resources(:surveys, only: [:new, :create, :show, :update]) do
              router.resources(:rolls, only: [:create])
            end
          end
        end
      end
    end
  end
end
