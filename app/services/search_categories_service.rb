class SearchCategoriesService
  def self.call(search: nil)
    model = Category.all
    model.where("substring(LOWER(categories.name_ua)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL OR
                substring(LOWER(categories.name_en)::varchar from '.*' || :search::varchar || '(.*)$') IS NOT NULL",
                search: QueryNormalizer.remove_special_symbols(search.downcase))
  end
end
