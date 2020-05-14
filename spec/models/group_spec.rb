# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  fixtures :groups, :users

  subject { described_class.new }

  it 'is invalid without parameters' do
    expect(subject.valid?).to be_falsy
  end

  it 'is invalid without name' do
    subject = groups(:no_name)
    expect(subject.valid?).to be_falsy
  end

  it 'is valid with valid name' do
    subject = groups(:user_created)
    expect(subject.valid?).to be_truthy
  end

  it 'is invalid if attachment is wrong type' do
    file = fixture_file_upload(
      Rails.root.join('spec/fixtures/files',
                      'dummy.txt'), 'text/plain'
    )
    subject = described_class.new(name: 'Sample Name Y',
                                  user_id: 1, icon: file)

    expect(subject.valid?).to be_falsy
  end

  it 'returns default icon if no icon is present' do
    subject = groups(:user_created)
    expect(subject.icon_url).to match(/default-group/)
  end

  it 'returns attachment if attachment was correct' do
    file = fixture_file_upload(
      Rails.root.join('spec/fixtures/files/', 'avatar-ninja.png'),
      'image/png'
    )
    subject = described_class.new(name: 'Sample Name z',
                                  icon: file, user_id: 1)

    expect(subject.icon_url).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
