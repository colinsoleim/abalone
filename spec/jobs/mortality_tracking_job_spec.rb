require 'rails_helper'

RSpec.describe MortalityTrackingJob do
  let(:filename) { 'example_of_mortality_tracking_data.csv' }

  before(:all) { Rails.application.load_seed }

  it_behaves_like 'import job'
end
