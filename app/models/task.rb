class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 10 }
  validates :amount, presence: true
  validate :valid_time
  validates_associated :author

  belongs_to :author, class_name: 'User'
  belongs_to :group, optional: true

  scope :external, -> { where(group_id: nil) }
  scope :internal, -> { where.not(group_id: nil) }

  def icon_url
    return group.icon_url if !group.nil?
    
    'default-group-icon.png'
  end

  protected

  def valid_time
    unless !amount.nil? && amount > 0
      errors.add(:amount, 'Invalid time spent')
    end
  end

end