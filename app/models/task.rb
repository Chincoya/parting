class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 10 }
  validates :amount, presence: true
  validate :valid_time
  validates_associated :author

  belongs_to :author, class_name: 'User'
  private
  def valid_time
    return !amount.nil? &&
            amount > 0  &&
  end
end