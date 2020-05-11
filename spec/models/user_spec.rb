require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  subject { described_class.new }

  it 'is invalid without parameters' do
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid without usermane' do
    subject = users(:no_username)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid without email' do
    subject = users(:no_email)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid if email does not match regex validation' do
    subject = users(:bad_email)
    expect(subject.valid?).to be_falsy
  end

end
