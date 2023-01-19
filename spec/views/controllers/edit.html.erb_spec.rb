require 'rails_helper'

RSpec.describe 'controllers/edit', type: :view do
  before(:each) do
    @controller = assign(:controller, Controller.create!(
                                        user: 'MyString'
                                      ))
  end

  it 'renders the edit controller form' do
    render

    assert_select 'form[action=?][method=?]', controller_path(@controller), 'post' do
      assert_select 'input[name=?]', 'controller[user]'
    end
  end
end
