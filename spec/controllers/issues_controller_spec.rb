require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe IssuesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Issue. As you add validations to Issue, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:issue)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:issue, title: nil, user_id: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # IssuesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'As Regular User' do
    before(:each) do
      @user = FactoryBot.create(:user)
      auth_headers = @user.create_new_auth_token
      request.headers.merge!(auth_headers)
    end

    let(:valid_user_attributes){
      valid_attributes.merge(user_id: @user.id)
    }

    let(:invalid_user_attributes){
      invalid_attributes.merge(user_id: @user.id)
    }


    describe 'GET #index' do
      it 'returns a success response' do
        issue = Issue.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        issue = Issue.create! valid_user_attributes
        get :show, params: {id: issue.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Issue' do
          expect {
            post :create, params: {issue: valid_user_attributes}, session: valid_session
          }.to change(Issue, :count).by(1)
        end

        it 'receive 403 error code because it is someone else issue' do
            post :create, params: {issue: valid_attributes}, session: valid_session
            expect(response).to have_http_status(403)
        end

        it 'renders a JSON response with the new issue' do

          post :create, params: {issue: valid_user_attributes}, session: valid_session
          expect(response).to have_http_status(:created)
          expect(response.content_type).to eq('application/json')
          expect(response.location).to eq(issue_url(Issue.last))
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the new issue' do

          post :create, params: {issue: invalid_user_attributes}, session: valid_session
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          {title: 'New title', description: 'new description'}
        }

        it 'updates the requested issue' do
          issue = Issue.create! valid_attributes.merge(user_id: @user.id)
          put :update, params: {id: issue.to_param, issue: new_attributes}, session: valid_session
          issue.reload
          expect(issue.title).to eq(new_attributes[:title])
          expect(issue.description).to eq(new_attributes[:description])
        end

        it 'renders a JSON response with the issue' do
          issue = Issue.create! valid_user_attributes

          put :update, params: {id: issue.to_param, issue: valid_attributes}, session: valid_session
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json')
        end

        it 'renders a JSON response with 403 error code' do
          issue = Issue.create! valid_attributes

          put :update, params: {id: issue.to_param, issue: valid_attributes}, session: valid_session
          expect(response).to have_http_status(403)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the issue' do
          issue = Issue.create! valid_user_attributes

          put :update, params: {id: issue.to_param, issue: invalid_user_attributes}, session: valid_session
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested issue' do
        issue = Issue.create! valid_attributes
        delete :destroy, params: {id: issue.to_param}, session: valid_session
        expect(response).to have_http_status(403)
      end

      it 'destroys the requested issue' do
        issue = Issue.create! valid_user_attributes
        expect {
          delete :destroy, params: {id: issue.to_param}, session: valid_session
        }.to change(Issue, :count).by(-1)
      end
    end

  end

  describe 'As Manager User' do
    before(:each) do
      @manager = FactoryBot.create(:manager)
      auth_headers = @manager.create_new_auth_token
      request.headers.merge!(auth_headers)
    end

    let(:valid_manager_attributes){
      valid_attributes.merge(manager_id: @manager.id)
    }

    let(:invalid_manager_attributes){
      invalid_attributes.merge(manager_id: @manager.id)
    }


    describe 'GET #index' do
      it 'returns a success response' do
        issue = Issue.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        issue = Issue.create! valid_manager_attributes
        get :show, params: {id: issue.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Issue' do
          post :create, params: {issue: valid_manager_attributes}, session: valid_session
          expect(response).to have_http_status(403)
          expect(response.content_type).to eq('application/json')
        end
      end
      context 'with invalid params' do
        it 'renders a JSON response with errors for the new issue' do

          post :create, params: {issue: invalid_manager_attributes}, session: valid_session
          expect(response).to have_http_status(403)
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          {title: 'New title', description: 'new description'}
        }

        it 'updates the requested issue' do
          issue = Issue.create! valid_manager_attributes
          put :update, params: {id: issue.to_param, issue: new_attributes}, session: valid_session
          issue.reload
          expect(issue.title).to eq(new_attributes[:title])
          expect(issue.description).to eq(new_attributes[:description])
        end

        it 'renders a JSON response with the issue' do
          issue = Issue.create! valid_manager_attributes

          put :update, params: {id: issue.to_param, issue: valid_attributes}, session: valid_session
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json')
        end

        it 'renders a JSON response with an issue without manager' do
          issue = Issue.create! valid_attributes.merge(manager_id: nil)
          put :update, params: {id: issue.to_param, issue: valid_manager_attributes}, session: valid_session
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json')
        end

        it 'renders a 403 code JSON response with an issue with distinct manager' do
          issue = Issue.create! valid_attributes.merge(manager_id: FactoryBot.create(:manager).id)
          put :update, params: {id: issue.to_param, issue: valid_manager_attributes}, session: valid_session
          expect(response).to have_http_status(403)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the issue' do
          issue = Issue.create! valid_manager_attributes

          put :update, params: {id: issue.to_param, issue: invalid_manager_attributes}, session: valid_session
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested issue' do
        issue = Issue.create! valid_attributes
        delete :destroy, params: {id: issue.to_param}, session: valid_session
        expect(response).to have_http_status(403)
      end

      it 'destroys the requested issue' do
        issue = Issue.create! valid_manager_attributes
        delete :destroy, params: {id: issue.to_param}, session: valid_session
        expect(response).to have_http_status(403)
      end
    end

  end
end