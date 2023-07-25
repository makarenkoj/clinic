module QueryNormalizer
  # Remove special chars from search string
  # @param [String] search
  def self.remove_special_symbols(search)
    # regexp = /[\]\[\}\{!\\<\|>,\"#&*+?`$)(^%~\':;№=]/
    regexp = /[\]\[}{!\\<|>,"#&*+?`$)(^%~':;№=]/

    search&.gsub(regexp, '')
  end
end
