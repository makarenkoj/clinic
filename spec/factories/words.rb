FactoryBot.define do
  factory :word do
    association :dictionary
    original { 'hello' }
    translate { 'привіт' }
    transcription { 'həˈləʊ' }
  end
end
