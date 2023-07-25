class SearchService
  def self.main_query
    User.distinct.select('users.*').joins("INNER JOIN doctor_profiles on users.id = doctor_profiles.user_id
                  LEFT JOIN categories_doctors on doctor_profiles.id = categories_doctors.doctor_profile_id
                  LEFT JOIN categories on categories_doctors.category_id = categories.id
                  LEFT JOIN doctors_appointments on doctor_profiles.id = doctors_appointments.doctor_profile_id").all
  end

  def self.call(search: nil)
    model = main_query
    model.where("substring(LOWER(users.username)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL OR
                 substring(LOWER(categories.name_ua)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL OR
                 substring(LOWER(categories.name_en)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL",
                search: QueryNormalizer.remove_special_symbols(search))
  end
end
