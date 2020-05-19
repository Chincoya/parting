# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:all) do
    @user = create(:user)
  end

  it 'is invalid without parameters' do
    group = build(:group, name: nil, user_id: nil)
    expect(group.valid?).to be_falsy
  end

  it 'is invalid without name' do
    group = build(:group, name: nil)
    expect(group.valid?).to be_falsy
  end

  it 'is valid with valid name' do
    group = build(:group)
    expect(group.valid?).to be_truthy
  end

  it 'is invalid if attachment is wrong type' do
    file = fixture_file_upload(
      Rails.root.join('spec/fixtures/files',
                      'dummy.txt'), 'text/plain'
    )
    group = build(:group, icon: file)

    expect(group.valid?).to be_falsy
  end

  it 'returns default icon if no icon is present' do
    group = build(:group)
    expect(group.icon_url).to match(/default-group/)
  end

  it 'returns attachment if attachment was correct' do
    file = fixture_file_upload(
      Rails.root.join('spec/fixtures/files/', 'avatar-ninja.png'),
      'image/png'
    )
    group = build(:group, icon: file, user_id: 1)

    expect(group.icon_url).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
