module Routes
  module BaseRoutes
    FRONTEND_URL_MAPPING = {
      appointment: {
        en: '/doctors_appointments',
        ua: '/doctors_appointments'
      }
    }.freeze

    def url(path)
      locale = I18n.locale == I18n.default_locale ? '' : '/en'
      ENV.fetch('FRONTEND_URL') + locale + path
    end

    def admin_url(path)
      "#{ENV.fetch('BACKEND_URL')}/admin#{path}"
    end

    # Localized path
    def localized_path(path_key)
      FRONTEND_URL_MAPPING.dig(path_key.to_sym, I18n.locale.to_sym) || ''
    end
  end
end
