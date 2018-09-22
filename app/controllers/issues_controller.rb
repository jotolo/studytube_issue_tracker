class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :update, :destroy]
  load_and_authorize_resource

  api :GET, '/issues', 'Return all issues.'
  description 'Users: see the list of only your issues (most recent at the top) | Managers: be able to see the list of all issues.'
  error 403, 'Forbidden, for anonymous users.'
  formats ['json']
  def index
    @issues = user_signed_in? && current_user.has_role?(:manager) ? Issue.all : current_user.issues
    # users and managers should be able to filter by “status”
    @issues = @issues.by_status(params[:status]) if params[:status]
    render json: @issues
  end

  api :GET, '/issues/:id', 'Return issue information'
  param :id, Integer, required: true
  description 'Users: see only your issues (most recent at the top) | Managers: be able to see all issues.'
  error 403, 'Forbidden, for anonymous users.'
  def show
    render json: @issue
  end

  api :POST, '/issues', 'Create a new issue.'
  param :title, String, required: true
  param :description, String
  param :user_id, Integer, required: true
  param :manager_id, Integer
  param :status, Integer
  description 'Users: be able to create only your issues | Managers: Cannot create issues.'
  error 403, 'Forbidden, for anonymous users and manager users.'
  formats ['json']
  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      render json: @issue, status: :created, location: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/issues/:id', 'Update issue information'
  param :id, Integer, required: true
  param :title, String
  param :description, String
  param :user_id, Integer
  param :manager_id, Integer
  param :status, Integer
  description 'Only available for logged users. Users: not be able to update the status of your issues, not be able to update the assignend manager of your issues | Managers: be able to assign an issue to only yourself and only if it is not already assigned to somebody else, be able to unassign an issue from yourself, be able to change the status of the issue only if the issue is assigned to you, not be able to assign an issue to somebody else, not be able to change the status of an issue unless it is assigned to you.'
  error 403, 'Forbidden, for anonymous users or users that does not belong to the issue'
  formats ['json']
  def update
    if @issue.try_update(current_user, issue_params)
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/issues/:id', 'Destroy the issue with the given :id.'
  param :id, Integer, required: true
  description 'Users: be able to destroy only your issues | Managers: Cannot destroy issues.'
  error 403, 'Forbidden, for anonymous users and manager users.'
  formats ['json']
  def destroy
    @issue.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def issue_params
      params.require(:issue).permit(:title, :description, :user_id, :manager_id, :status).tap {
        |u| u[:status] = u[:status].to_i
      }
    end
end
