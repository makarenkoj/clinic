module Routes
  class AppointmentRoutes
    extend Routes::BaseRoutes

    # Route to appointment
    def self.appointment_url(id)
      path = localized_path(:appointment)
      url("#{path}/#{id}")
    end
  end
end
