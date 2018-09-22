class Issue < ApplicationRecord
  # Scopes
  default_scope { order(created_at: :asc) }
  scope :by_status, ->(status) { where(status: status) }

  # Relationships
  belongs_to :user
  belongs_to :manager, class_name:'User', foreign_key: 'manager_id', optional: true
  enum status: [:pending, :in_progress, :resolved]

  # Validations
  validates :title, presence: true
  validate :statuses_and_assignation

  # Methods

  def try_update(user, params)
    if user.is_manager?
      # - be able to assign an issue to only yourself and only if it is not already assigned to somebody else
      # - be able to unassign an issue from yourself
      # - not be able to assign an issue to somebody else
      if params.include?(:manager_id) && !params[:manager_id].nil? && params[:manager_id] != user.id
        self.errors.add(:manager_id, 'You cannot assign another manager to this issue.')
      end

    elsif user.is_user?
      # - not be able to update the status of your issues
      self.errors.add(:status, 'You are not allowed to change the status of this issue.' ) if params.include?('status')
      # - not be able to update the assigned manager of your issues
      self.errors.add(:manager_id, 'You are not allowed to change the manager of this issue.' ) if params.include?('manager_id')

    end

    self.update(params)
  end

  private

  def statuses_and_assignation
    if (self.in_progress? || self.resolved?) && self.user_id.nil?
      self.errors.add(:status, 'You cannot have this status without assignee.')
    end
  end
end
