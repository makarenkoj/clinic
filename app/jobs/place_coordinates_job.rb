class PlaceCoordinatesJob < ApplicationJob
  queue_as :default

  def perform(place_id)
    place = Place.find(place_id)
    result = Geocoder.search(place.location)
    if result.present?
      coordinates = result.first.coordinates
      place.update(x: coordinates[0], y: coordinates[1])
    else
      Rails.logger.error("Geocoder failed to find coordinates for location: #{place.location}")
    end
  end
end
