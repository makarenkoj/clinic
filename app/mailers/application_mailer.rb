class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_EMAIL'] || 'support@clinic.com'
  layout 'mailer'

  def mail_active_recipient_only(recipient, **args)
    mail(to: recipient.email, **args)
  end
end
