require 'rails_helper'

RSpec.describe PlaceCoordinatesJob, type: :job do
  include ActiveJob::TestHelper

  let(:place) { create(:place, location: 'Kyiv', x: nil, y: nil) }

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  it 'enqueues the job' do
    expect do
      PlaceCoordinatesJob.perform_later(place.id)
    end.to have_enqueued_job(PlaceCoordinatesJob).with(place.id).on_queue('default')
  end

  it 'performs the job and updates coordinates' do
    geocoder_result = double('Geocoder::Result', coordinates: [50.45, 30.52])
    allow(Geocoder).to receive(:search).with('Kyiv').and_return([geocoder_result])

    perform_enqueued_jobs do
      PlaceCoordinatesJob.perform_later(place.id)
    end

    place.reload
    expect(place.x).to eq(50.45)
    expect(place.y).to eq(30.52)
  end

  it 'logs an error if coordinates not found' do
    allow(Geocoder).to receive(:search).with('Kyiv').and_return([])

    expect(Rails.logger).to receive(:error).with('Geocoder failed to find coordinates for location: Kyiv')

    perform_enqueued_jobs do
      PlaceCoordinatesJob.perform_later(place.id)
    end

    place.reload
    expect(place.x).to be_nil
    expect(place.y).to be_nil
  end
end
