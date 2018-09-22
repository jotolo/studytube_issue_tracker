require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'validations' do
    it 'title validation' do
      should validate_presence_of :title
    end

    it 'user validation' do
      is_expected.to belong_to(:user)
    end
  end
end
