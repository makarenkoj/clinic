module ApplicationHelper
  def emoji_flag(country_code)
    cc = country_code.to_s.upcase
    return unless cc =~ /\A[A-Z]{2}\z/

    cc.codepoints.map { |c| (c + 127_397).chr(Encoding::UTF_8) }.join
  end
end
