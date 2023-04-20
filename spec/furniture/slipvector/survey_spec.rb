require "rails_helper"

RSpec.describe Slipvector::Survey, type: :model do
  it { is_expected.to belong_to(:surveyors_guild).inverse_of(:surveys) }
  it { is_expected.to belong_to(:star_system).inverse_of(:surveys) }
end
