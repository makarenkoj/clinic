module ApplicationHelper
  def emoji_flag(country_code)
    cc = country_code.to_s.upcase
    return unless cc =~ /\A[A-Z]{2}\z/

    cc.codepoints.map { |c| (c + 127_397).chr(Encoding::UTF_8) }.join
  end

  def date_format(object)
    return if object.blank?

    object&.strftime('%H:%M %d/%m/%Y')
  end

  def current_user_can_edit?(model)
    user_signed_in? && model.user == current_user
  end
end
