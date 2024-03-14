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

  def asset_path(path)
    ENV.fetch('BACKEND_URL', nil) + path
  end

  def paginate(result)
    content_tag :li, class: "page-item" do
      concat(render_pagination_link '<<',
             result.current_page - 1,
             result.current_page <= 1
            )
      concat(render_pagination_link '>>',
             result.current_page + 1,
             result.current_page >= result.total_pages
      )
    end
  end

  def render_pagination_link(label, page, disabled)
    content_tag :li, class: ('page-item disabled' if disabled) do
      link_to_unless disabled, label, notes_path(page: page)
    end
  end
end
