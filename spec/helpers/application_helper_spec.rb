require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'paginate' do
    subject(:paginate) { helper.paginate(result) }

    let(:result) do
      instance_double(PaginationResultService, current_page: current_page, total_pages: 3)
    end

    let(:current_page) { 2 }

    it { is_expected.to include('<a href="/notes?page=1">&lt;&lt;</a>') }
    it { is_expected.to include('<a href="/notes?page=3">&gt;&gt;</a>') }

    context 'on first page' do
      let(:current_page) { 1 }

      it { is_expected.to_not match(%r{<a(.*)>previous</a>}) }
    end

    context 'on last page' do
      let(:current_page) { 3 }

      it { is_expected.to_not match(%r{<a(.*)>next</a>}) }
    end
  end

  describe 'emoji_flag' do
    it 'return correct flag' do
      expect(helper.emoji_flag('ua')).to eql '🇺🇦'
    end
  end

  describe 'date format' do
    it 'return correct format' do
      expect(helper.date_format(Time.now)).to eql Time.now.strftime('%H:%M %d/%m/%Y')
    end

    it 'return if object blank' do
      expect(helper.date_format(nil)).to eql nil
    end
  end
end
