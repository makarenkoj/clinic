require 'rails_helper'

# rspec spec/services/appointment_notification_service_spec.rb

describe AppointmentNotificationServices do
  # let(:doctors_appointment) { create(:doctors_appointment, visit_time: Time.now + 3.day + 30.minutes) }
  # let(:doctors_appointment2) { create(:doctors_appointment, visit_time: Time.now + 3.day + 1.hours) }
  # let(:doctors_appointment3) { create(:doctors_appointment, visit_time: Time.now + 3.day + 65.minutes) }

  # before do
  #   doctors_appointment
  #   doctors_appointment2
  #   doctors_appointment3
  # end

  it 'send email notification' do
    doctors_appointment = create(:doctors_appointment, visit_time: Time.current + 3.day + 30.minutes)
    doctors_appointment2 = create(:doctors_appointment, visit_time: Time.current + 3.day + 1.hours)
    doctors_appointment3 = create(:doctors_appointment, visit_time: Time.zone.now + 3.day + 65.minutes)

    Timecop.freeze(Time.now + 2.day + 21.hours + 5.minutes)
    AppointmentNotificationServices.call
binding.break
Timecop.return
    # expect(SearchCategoriesService.call(search: category.name_en).size).to eql 1
    # expect(SearchCategoriesService.call(search: category.name_ua)[0].name_en).to eql category.name_en
    # expect(SearchCategoriesService.call(search: Category.second.name_ua).size).to eql 1
    # expect(SearchCategoriesService.call(search: Category.second.name_ua)[0].name_en).to eql Category.second.name_en
  end
end
