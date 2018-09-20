require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'email validation' do
      should validate_presence_of :email
    end
  end
end
