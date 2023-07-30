class AppointmentNotificationJob < ApplicationJob
  queue_as :default
  # include Sidekiq::Job

  def perform
    AppointmentNotificationServices.call
  end
end
