require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures fulname presence' do
    user = User.new(firstname: 'Daniel', lastname: 'Valle').save
    expect(user).to eq(false)
    end

    # it 'ensures complete user' do
    #   user = User.new(firstname: 'Test', lastname: 'Case', email: 'test@email.com', username: 'tester', id: Random.rand(10...42))
    #   expect(user).to eq(true)
    # end

  end

  context 'scope tests' do
    before(:each) do
      User.new(firstname: 'Winston', lastname: 'Churchill', email: 'winston@email.com', username: 'winston', id: Random.rand(10...42))
    end
  end
end


# context encapsulates several examples
#
