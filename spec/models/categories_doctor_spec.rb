require 'rails_helper'

RSpec.describe CategoriesDoctor, type: :model do
  describe 'asociation' do
    it { should belong_to(:category) }
    it { should belong_to(:doctor_profile) }
  end
end
