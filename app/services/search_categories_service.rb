class SearchCategoriesService
  # def self.doctor_categories(categories_ua: nil, categories_en: nil)
  #   model = main_query
  #   categories_ua.nil? ? model.where(categories: { name_ua: categories_ua }) : model.where(categories: { name_en: categories_en })
  # end

  # def self.call(search: nil)
  #   model = main_query
  #   model.where("substring(LOWER(categories.name_ua)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL OR
  #               substring(LOWER(categories.name_en)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL",
  #               search: QueryNormalizer.remove_special_symbols(search))
  # end

    # def self.multi_word_search(search:)
  #   model = main_query
  #   word1 = search.split[0]
  #   word2 = search.split[1..].join(' ')

  #   model.where("substring(LOWER(users.username)::varchar from '^' || :search::varchar || '(.*)$') IS NOT NULL OR
  #                substring(LOWER(categories.name_ua)::varchar from '^' || :search::varchar || '(.*)$') IS NOT NULL OR
  #                substring(LOWER(categories.name_en)::varchar from '^' || :search::varchar || '(.*)$') IS NOT NULL OR",
  #               search: QueryNormalizer.remove_special_symbols(search),
  #               word1: QueryNormalizer.remove_special_symbols(word1),
  #               word2: QueryNormalizer.remove_special_symbols(word2))
  # end

    # def self.visit_dates(dates: nil)
  #   model = main_query
  #   model.where.not(doctors_appointments: { visit_time: dates })
  # end

  # def self.doctor_categories(categories_ua: nil, categories_en: nil)
  #   model = main_query
  #   categories_ua.nil? ? model.where(categories: { name_ua: categories_ua }) : model.where(categories: { name_en: categories_en })
  # end
end
