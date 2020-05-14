# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, presence: true, format: { without: /\ANone\Z/ }
  validate :accept_icon

  belongs_to :user
  has_one_attached :icon
  has_many :tasks

  def icon_url
    return icon if icon.attached?

    'default-group-icon.png'
  end

  protected

  def accept_icon
    return unless icon.attached?

    accept_types = ['image/jpeg', 'image/png']
    if icon.byte_size >= 1.megabyte
      errors.add(:icon, ': File is too big')
    elsif !accept_types.include?(icon.content_type)
      errors.add(:icon, ': File is incorrect type. Acceptable types are PNG and JPEG')
    end
  end
end
