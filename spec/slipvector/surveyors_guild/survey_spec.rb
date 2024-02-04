require "rails_helper"

RSpec.describe Slipvector::SurveyorsGuild::Survey, type: :model do
  it { is_expected.to belong_to(:surveyors_guild).inverse_of(:surveys) }
  it { is_expected.to belong_to(:star_system).inverse_of(:surveys) }

  describe "#next_roll" do
    context "when there isn't a first roll" do
      it "creates a first roll with the given dice"
    end
  end
end
