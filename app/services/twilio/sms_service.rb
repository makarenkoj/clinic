module Twilio
  class SmsService
    TWILIO_ACCOUNT_SID = ENV.fetch('TWILIO_ACCOUNT_SID', nil)
    TWILIO_AUTH_TOKEN = ENV.fetch('TWILIO_AUTH_TOKEN', nil)
    TWILIO_TO_PHONE = ENV.fetch('TWILIO_TO_PHONE', nil)
    TWILIO_FROM_PHONE = ENV.fetch('TWILIO_FROM_PHONE', nil)

    def initialize(body:, to_phone_number:)
      @body = body
      @to_phone_number = to_phone_number
    end

    def call
      @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
      @client.messages.create(
        body: @body,     
        to: to(@to_phone_number),
        from: TWILIO_FROM_PHONE
        # from: '+15856011494'
      ) # Magic Number for creating SMS
      
      
      # Twilio::SmsService.new(body: 'Hello its me',to_phone_number: '+15856011494').call
    end

    private

    def to(to_phone_number)
      Rails.env.development? || Rails.env.test? ? TWILIO_TO_PHONE : to_phone_number
    end
  end
end
