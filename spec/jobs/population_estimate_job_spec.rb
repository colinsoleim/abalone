require 'rails_helper'

RSpec.describe PopulationEstimateJob do
  let(:filename) { 'example_of_population_estimate_data.csv' }

  before(:all) { Rails.application.load_seed }

  it_behaves_like 'import job'
end
