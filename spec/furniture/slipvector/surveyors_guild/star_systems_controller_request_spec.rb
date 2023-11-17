require "rails_helper"

RSpec.describe Slipvector::SurveyorsGuild::StarSystemsController, type: :request do
  let(:membership) { create(:membership, space: space) }
  let(:member) { membership.member }
  let(:surveyors_guild) { create(:slipvector_surveyors_guild) }
  let(:space) { surveyors_guild.space }

  describe "#create" do
    context "when a Space Member submits a valid Star System" do
      before { sign_in(space, member) }

      it "creates the star system and flashes a confirmation" do
        post polymorphic_path(surveyors_guild.location(child: :star_systems))
        expect(flash[:notice]).to eq I18n.t("slipvector.surveyors_guild.star_systems.create.success")
        expect(response).to redirect_to(surveyors_guild.location)
      end
    end
  end
end
