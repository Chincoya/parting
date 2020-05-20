# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without parameters' do
    user = build(:user, name: nil, email: nil, password: nil)
    expect(user.valid?).to be_falsy
  end

  it 'is invalid without usermane' do
    user = build(:user, name: nil, email: 'example@mail.com', password: 'password')
    expect(user.valid?).to be_falsy
  end

  it 'is invalid without email' do
    user = build(:user, name: 'Bob Exotic', email: nil, password: 'password')
    expect(user.valid?).to be_falsy
  end

  it 'is invalid if email does not match regex validation' do
    user = build(:user, name: 'Bob Exotic', email: 'bobexotic.com', password: 'password')
    expect(user.valid?).to be_falsy
  end

  it 'is valid with valid parameters' do
    user = build(:user)
    expect(user).to be_valid
  end
end
