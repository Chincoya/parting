class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 10 }
  validates :amount, presence: true
  validate :valid_time
  validates_associated :author

  belongs_to :author, class_name: 'User'
  belongs_to :group, optional: true

  protected

  def valid_time
    unless !amount.nil? && amount > 0
      errors.add(:amount, 'Invalid time spent')
    end
  end

end