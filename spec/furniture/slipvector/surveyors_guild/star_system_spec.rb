require "rails_helper"

RSpec.describe Slipvector::SurveyorsGuild::StarSystem, type: :model do
  it { is_expected.to belong_to(:surveyors_guild).inverse_of(:star_systems) }
  it { is_expected.to have_many(:surveys).inverse_of(:star_system).dependent(:destroy) }
end
