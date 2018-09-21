# frozen_string_literal: true

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :issues
  has_many :manager_issues, :class_name => 'Issue', :foreign_key => 'manager_id'

  validates :email, presence: true

  after_create :assign_default_role

  private
  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
