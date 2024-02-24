require "rails_helper"

RSpec.describe Slipvector::SurveyorsGuild, type: :model do
  it { is_expected.to have_many(:star_systems).dependent(:destroy).inverse_of(:surveyors_guild) }
  it { is_expected.to have_many(:surveys).dependent(:destroy).inverse_of(:surveyors_guild) }

  describe "#surveys_seeking_crew" do
    it "creates surveys if none are seeking crew" do
      surveyors_guild = create(:slipvector_surveyors_guild)

      expect(surveyors_guild.surveys_seeking_crew.length)
        .to eql(surveyors_guild.maximum_available_surveys)
    end

    it "doesn't create a survey if any are seeking crew" do
      surveyors_guild = create(:slipvector_surveyors_guild)
      surveyors_guild.pull_survey

      expect { surveyors_guild.surveys_seeking_crew }
        .not_to(change(surveyors_guild.surveys, :count))
    end
  end
end
