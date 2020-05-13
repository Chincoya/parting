class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}     
  validate :accept_icon
  
  has_many :tasks, foreign_key: 'author_id', inverse_of: 'author'
  has_many :groups
  has_one_attached :icon

  def icon_url
    return icon if icon.attached?

    'default-user-icon.png'
  end

  protected

  def accept_icon
    return unless icon.attached?

    accept_types = ['image/jpeg', 'image/png']
    if icon.byte_size >= 1.megabyte
      errors.add(:icon, ': File is too big')
    elsif !(accept_types.include?(icon.content_type))
      errors.add(:icon, ': File is incorrect type. Acceptable types are PNG and JPEG')
    end

  end
end
