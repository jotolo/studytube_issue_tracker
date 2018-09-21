class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /issues
  def index
    @issues = user_signed_in? && current_user.has_role?(:manager) ? Issue.all : current_user.issues
    # users and managers should be able to filter by “status”
    @issues = @issues.by_status(params[:status]) if params[:status]
    render json: @issues
  end

  # GET /issues/1
  def show
    render json: @issue
  end

  # POST /issues
  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      render json: @issue, status: :created, location: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /issues/1
  def update
    if @issue.try_update(current_user, issue_params)
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /issues/1
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
