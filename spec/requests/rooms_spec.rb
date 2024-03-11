# bundle exec rspec spec/requests/rooms_spec.rb

require 'rails_helper'

RSpec.describe '/rooms', type: :request do
  include_context 'base'
end
