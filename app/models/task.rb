# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 8, maximum: 30 }
  validates :amount, presence: true
  validate :valid_time
  validates_associated :author

  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups, optional: true

  scope :internal, -> { joins(:groups_tasks) }
  scope :external, -> { includes(:groups_tasks).where("groups_tasks.group_id IS NULL").references(:groups_tasks) }
  
  #scope :external, -> { find_by_sql("
  #                      SELECT tasks.* FROM tasks
  #                      LEFT OUTER JOIN groups_tasks ON groups_tasks.task_id = tasks.id
  #                      WHERE groups_tasks.group_id IS NULL
  #                      ") }
  scope :user_external, -> (user_id) { find_by_sql(["
                                        SELECT tasks.* FROM tasks
                                        LEFT OUTER JOIN groups_tasks ON groups_tasks.task_id = tasks.id
                                        WHERE tasks.author_id = ? AND groups_tasks.group_id IS NULL
                                       ", user_id])

  }
  def icon_url
    return group.icon_url unless group.nil?

    'default-group-icon.png'
  end

  protected

  def valid_time
    errors.add(:amount, 'Invalid time spent') unless !amount.nil? && amount.positive?
  end
end
