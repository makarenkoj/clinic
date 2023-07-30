namespace :scheduler do
  desc 'This task is called by the Appointment Notification Job every 30 min'
  task appointment_notification_ping: :environment do
    # every 15 min
    AppointmentNotificationJob.perform_async
  end
end
