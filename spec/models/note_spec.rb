require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:date_time).of_type(:datetime) }
    it { is_expected.to have_db_column(:body).of_type(:string) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
  end

  describe 'validation' do
    context 'presents' do
      it { is_expected.to validate_presence_of(:date_time) }
      it { is_expected.to validate_presence_of(:body) }
    end
  end

  describe 'paginate' do
    subject { Note.paginate(page: 3, per_page: 2) }

    let!(:note1) { create(:note, body: '1') }
    let!(:note2) { create(:note, body: '2') }
    let!(:note3) { create(:note, body: '3') }
    let!(:note4) { create(:note, body: '4') }
    let!(:note5) { create(:note, body: '5') }
    let!(:note6) { create(:note, body: '6') }
    let!(:note7) { create(:note, body: '7') }

    it { is_expected.to eq([note5, note6]) }

    it 'total pages' do
      expect(subject.total_pages).to eql 4
    end

    it 'current page' do
      expect(subject.current_page).to eql 3
    end
  end
end
