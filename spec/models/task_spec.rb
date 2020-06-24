# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:all) do
    @user = create(:user)
  end

  it 'is invalid without parameters' do
    task = build(:task, name: nil, amount: nil, author_id: nil)
    expect(task.valid?).to be_falsy
  end

  it 'is invalid without name' do
    task = build(:task, name: nil)
    expect(task.valid?).to be_falsy
  end

  it 'is invalid without amount' do
    task = build(:task, amount: nil)
    expect(task.valid?).to be_falsy
  end

  it 'is invalid without author' do
    task = build(:task, author_id: nil)
    expect(task.valid?).to be_falsy
  end

  it 'is invalid if name is too short ( < 10 chars )' do
    task = build(:task, name: 'char')
    expect(task.valid?).to be_falsy
  end

  it 'is invalid if amount is negative or zero' do
    task = build(:task, amount: -10)
    expect(task.valid?).to be_falsy
  end

  it 'is invalid if author does not exist in DB' do
    task = build(:task, author_id: 30)
    expect(task.valid?).to be_falsy
  end
end
