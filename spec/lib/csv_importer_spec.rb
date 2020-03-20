require 'rails_helper'

RSpec.describe CsvImporter do
  describe '#process' do
    let(:processed_file) { create(:processed_file) }
    let(:category_name) { 'Tagged Animal Assessment' }

    context 'when csv file is perfect' do
      it 'imports all the records' do
        file =
          File.read(
            Rails.root.join(
              'spec/support/csv/Tagged_assessment_valid_values.csv'
            )
          )

        expect {
          CsvImporter.new(file, category_name, processed_file.id).call
        }.to change { TaggedAnimalAssessment.count }.by 3
      end
    end

    context "when there're errors importing a row" do
      it 'does not import any record' do
        file =
          File.read(
            Rails.root.join(
              'spec',
              'support',
              'csv',
              'Tagged_assessment_invalid_values.csv'
            )
          )

        expect {
          CsvImporter.new(file, category_name, processed_file.id).call
        }.not_to change { TaggedAnimalAssessment.count }
      end

      it 'provides error details' do
        file =
          File.read(
            Rails.root.join(
              'spec',
              'support',
              'csv',
              'Tagged_assessment_invalid_values.csv'
            )
          )
        importer = CsvImporter.new(file, category_name, processed_file.id)

        expect { importer.call }.not_to change { TaggedAnimalAssessment.count }
        expect(importer.errored?).to eq(true)
        expect(importer.error_details.empty?).to eq(false)
      end
    end
  end
end
