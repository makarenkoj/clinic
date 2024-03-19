require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'paginate' do
    subject(:paginate) { helper.paginate(result) }
  
    let(:result) { double }
  
    context 'when result contains DoctorProfile objects' do
      before do
        allow(result).to receive(:first).and_return(DoctorProfile.new)
        allow(result).to receive(:current_page).and_return(2)
        allow(result).to receive(:total_pages).and_return(3)
      end
  
      it { is_expected.to include('<a href="/doctor_profiles?page=1">&lt;&lt;</a>') }
      it { is_expected.to include('<a href="/doctor_profiles?page=3">&gt;&gt;</a>') }
  
      context 'on first page' do
        before { allow(result).to receive(:current_page).and_return(1) }
  
        it { is_expected.to_not match(%r{<a(.*)>previous</a>}) }
      end
  
      context 'on last page' do
        before { allow(result).to receive(:current_page).and_return(3) }
  
        it { is_expected.to_not match(%r{<a(.*)>next</a>}) }
      end
    end
  
    context 'when result contains Note objects' do
      before do
        allow(result).to receive(:first).and_return(Note.new)
        allow(result).to receive(:current_page).and_return(2)
        allow(result).to receive(:total_pages).and_return(3)
      end
  
      it { is_expected.to include('<a href="/notes?page=1">&lt;&lt;</a>') }
      it { is_expected.to include('<a href="/notes?page=3">&gt;&gt;</a>') }
  
      context 'on first page' do
        before { allow(result).to receive(:current_page).and_return(1) }
  
        it { is_expected.to_not match(%r{<a(.*)>previous</a>}) }
      end
  
      context 'on last page' do
        before { allow(result).to receive(:current_page).and_return(3) }
  
        it { is_expected.to_not match(%r{<a(.*)>next</a>}) }
      end
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
