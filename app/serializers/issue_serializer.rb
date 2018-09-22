class IssueSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status
  belongs_to :user
  belongs_to :manager
end
