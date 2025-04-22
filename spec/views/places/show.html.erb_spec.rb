require 'rails_helper'

RSpec.describe 'places/show', type: :view do
  # let(:current_user) { create(:user, :doctor_type) }
  # let(:place) { create(:place, doctor_profile: current_user.doctor_profile, x: 49.0, y: 32.0) }

  # before do
  #   sign_in current_user
  #   assign(:place, place)
  #   allow(view).to receive(:current_user).and_return(current_user)
  #   render
  # end

  # it 'відображає імʼя місця' do
  #   expect(rendered).to match(/#{place.name}/)
  # end

  # it 'відображає координати X та Y' do
  #   expect(rendered).to match(/49\.0/)
  #   expect(rendered).to match(/32\.0/)
  # end

  # it 'рендерить partial _place' do
  #   expect(rendered).to have_selector("##{dom_id(place)}")
  # end

  # it 'має посилання на редагування' do
  #   expect(rendered).to have_link(I18n.t('places.edit'), href: edit_doctor_profile_place_path(place.doctor_profile, place))
  # end

  # it 'має кнопку для видалення з підтвердженням' do
  #   expect(rendered).to have_selector("form[action='#{doctor_profile_place_path(place.doctor_profile, place)}'][method='post']")
  #   expect(rendered).to have_selector("input[type='submit'][value='#{I18n.t('places.destroy')}']")
  # end

  # it 'відображає карту з правильними координатами' do
  #   expect(rendered).to include('data-map-x-value="49.0"')
  #   expect(rendered).to include('data-map-y-value="32.0"')
  # end
end
