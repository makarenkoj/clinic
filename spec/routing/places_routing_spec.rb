require 'rails_helper'

RSpec.describe PlacesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/ua/doctor_profiles/1/places/2').to route_to(
        'places#show',
        doctor_profile_id: '1',
        id: '2',
        locale: 'ua'
      )
    end

    it 'routes to #new' do
      expect(get: '/ua/doctor_profiles/1/places/new').to route_to(
        'places#new',
        doctor_profile_id: '1',
        locale: 'ua'
      )
    end

    it 'routes to #create' do
      expect(post: '/ua/doctor_profiles/1/places').to route_to(
        'places#create',
        doctor_profile_id: '1',
        locale: 'ua'
      )
    end

    it 'routes to #edit' do
      expect(get: '/ua/doctor_profiles/1/places/2/edit').to route_to(
        'places#edit',
        doctor_profile_id: '1',
        id: '2',
        locale: 'ua'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/ua/doctor_profiles/1/places/2').to route_to(
        'places#update',
        doctor_profile_id: '1',
        id: '2',
        locale: 'ua'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/ua/doctor_profiles/1/places/2').to route_to(
        'places#update',
        doctor_profile_id: '1',
        id: '2',
        locale: 'ua'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/ua/doctor_profiles/1/places/2').to route_to(
        'places#destroy',
        doctor_profile_id: '1',
        id: '2',
        locale: 'ua'
      )
    end
  end
end
