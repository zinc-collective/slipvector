class Slipvector
  class SurveyorsGuild
    class Routes
      def self.append_routes(router)
        router.resources(:surveyors_guilds, only: [:show], module: "slipvector/surveyors_guild") do
          router.resources(:star_systems, only: [:create])
        end
      end
    end
  end
end
