class Slipvector
  class Controller < ApplicationController
    layout "slipvector"
    default_form_builder FormBuilder

    expose :surveyors_guild, model: SurveyorsGuild

    helper_method def href_for(resource, action: :show, child: nil, query_params: nil)
      polymorphic_path(resource.location(action, child:, query_params:))
    end

    def pundit_user
      PunditUser.new(super, surveyor: current_surveyor)
    end

    helper_method def current_surveyor
      @current_surveyor ||= if session[:slipvector_current_surveyor_id]
        @current_surveyor =
          Surveyor.find(session[:slipvector_current_surveyor_id])
      end
    end

    def current_surveyor= surveyor
      session[:slipvector_current_surveyor_id] = surveyor.id
      @current_surveyor = surveyor
    end

    def handle_unauthorized
      redirect_to surveyors_guild.location, alert: "Sorry, that's private..."
    end
  end
end
