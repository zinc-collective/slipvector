class Slipvector
  class SurveyorsGuild
    class Routes
      def self.append_routes(router)
        router.resources(:surveyors_guilds, only: [:show], module: "slipvector") do
          router.resources(:star_systems, only: [:new, :create, :show], module: "surveyors_guild") do
            router.resources(:surveys, only: [:create, :show, :update], module: "star_system") do
              router.resources(:rolls, only: [:create], module: "survey")
            end
          end
        end
      end
    end
  end
end
