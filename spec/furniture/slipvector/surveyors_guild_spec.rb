require 'rails_helper'

RSpec.describe Slipvector::SurveyorsGuild, type: :model do
  it { is_expected.to have_many(:star_systems).dependent(:destroy).inverse_of(:surveyors_guild) }
  it { is_expected.to have_many(:surveys).dependent(:destroy).inverse_of(:surveyors_guild) }
end
