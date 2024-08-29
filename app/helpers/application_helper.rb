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

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def paginate(result)
    if result.first.instance_of?(::DoctorProfile)
      content_tag :li, class: 'page-item' do
        concat(render_doctor_profile_pagination_link('<<',
                                                     result.current_page - 1,
                                                     result.current_page <= 1))
        concat(render_doctor_profile_pagination_link('>>',
                                                     result.current_page + 1,
                                                     result.current_page >= result.total_pages))
      end
    elsif result.first.instance_of?(::Note)
      content_tag :li, class: 'page-item' do
        concat(render_notice_pagination_link('<<',
                                             result.current_page - 1,
                                             result.current_page <= 1))
        concat(render_notice_pagination_link('>>',
                                             result.current_page + 1,
                                             result.current_page >= result.total_pages))
      end
    elsif result.first.instance_of?(::PatientProfile)
      content_tag :li, class: 'page-item' do
        concat(render_patient_profile_pagination_link('<<',
                                                      result.current_page - 1,
                                                      result.current_page <= 1))
        concat(render_patient_profile_pagination_link('>>',
                                                      result.current_page + 1,
                                                      result.current_page >= result.total_pages))
      end
    elsif result.first.instance_of?(::Watching)
      content_tag :li, class: 'page-item' do
        concat(render_watching_pagination_link('<<',
                                               result.current_page - 1,
                                               result.current_page <= 1))
        concat(render_watching_pagination_link('>>',
                                               result.current_page + 1,
                                               result.current_page >= result.total_pages))
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def render_doctor_profile_pagination_link(label, page, disabled)
    content_tag :li, class: ('page-item disabled' if disabled) do
      link_to_unless disabled, label, doctor_profiles_path(page: page)
    end
  end

  def render_patient_profile_pagination_link(label, page, disabled)
    content_tag :li, class: ('page-item disabled' if disabled) do
      link_to_unless disabled, label, patient_profiles_path(page: page)
    end
  end

  def render_notice_pagination_link(label, page, disabled)
    content_tag :li, class: ('page-item disabled' if disabled) do
      link_to_unless disabled, label, notes_path(page: page)
    end
  end

  def render_watching_pagination_link(label, page, disabled)
    content_tag :li, class: ('page-item disabled' if disabled) do
      link_to_unless disabled, label, watchings_path(page: page)
    end
  end

  def order_by(direction)
    params.to_unsafe_h.merge(order: direction, only_path: true).except(:script_name, :original_script_name)
  end

  def trust_user
    true if current_user.email == 'makarenkoj53@gmail.com'
  end
end
