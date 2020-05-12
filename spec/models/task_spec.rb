require 'rails_helper'

RSpec.describe Task, type: :model do
  fixtures :tasks
  subject { described_class.new }

  it 'is invalid without parameters' do
    expect(subject.valid?).to be_falsy   
  end

  it 'is invalid without name' do
    subject = tasks(:no_name)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid without amount' do
    subject = tasks(:no_amount)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid without author' do
    subject = tasks(:no_author)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid if name is too short ( < 10 chars )' do
    subject = tasks(:invalid_name)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid if amount is negative or zero' do
    subject = tasks(:invalid_amount)
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid if author does not exist in DB' do
    subject = tasks(:invalid_author)
    expect(subject.valid?).to be_falsy
  end

end
