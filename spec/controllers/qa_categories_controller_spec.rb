require 'spec_helper'

describe QaCategoriesController do
  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}
  let(:qa_category) {FactoryGirl.create(:qa_category)}
  let(:valid_attributes) {{name: "Qa Category"}}

  describe "GET index" do
    before do
      qa_category
      get :index, {}, {user: user.id}
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns all qa categories as @qa_categories" do
      expect(assigns(:qa_categories)).to eq([qa_category])
    end
  end

  describe "GET show" do
    context "with super user" do
      before {get :show, {id: qa_category.id}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns the requested qa category as @qa_category" do
        expect(assigns(:qa_category)).to eq(qa_category)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        get :show, {id: qa_category.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET new" do
    context "with super user" do
      before {get :new, {}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns a new qa category as @qa_category" do
        expect(assigns(:qa_category)).to be_a_new(QaCategory)
      end
    end

    context "with general user" do
      before {get :new, {}, {user: user.id}}

      it "returns http not found" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET edit" do
    context "with super user" do
      before {get :edit, {id: qa_category.id}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested qa category as @qa_category" do
        expect(assigns(:qa_category)).to eq(qa_category)
      end
    end

    context "with general user" do
      before {get :edit, {id: qa_category.id}, {user: user.id}}

      it "returns http not found" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new QaCategory" do
        expect {
          post :create, {qa_category: valid_attributes}, {user: super_user.id}
        }.to change(QaCategory, :count).by(1)
      end

      it "returns http redirect" do
        post :create, {qa_category: valid_attributes}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to qa_categories_path" do
        post :create, {qa_category: valid_attributes}, {user: super_user.id}
        expect(response).to redirect_to(qa_categories_path)
      end

      it "assigns a newly created qa category as @qa_category" do
        post :create, {qa_category: valid_attributes}, {user: super_user.id}
        expect(assigns(:qa_category)).to be_a(QaCategory)
        expect(assigns(:qa_category)).to be_persisted
      end
    end

    context "with invalid params" do
      before do
        QaCategory.any_instance.should_receive(:save).and_return(false)
      end

      it "returns http success" do
        post :create, {qa_category: valid_attributes}, {user: super_user.id}
        expect(response).to be_success
      end

      it "re-renders the new template" do
        post :create, {qa_category: valid_attributes}, {user: super_user.id}
        expect(response).to render_template(:new)
      end

      it "don't create a new qa category" do
        expect {
          post :create, {qa_category: valid_attributes}, {user: super_user.id}
          }.not_to change(QaCategory, :count)
        expect(assigns(:qa_category)).to be_a_new(QaCategory)
      end
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      before do
        patch :update, {qa_category: valid_attributes, id: qa_category.id}, {user: super_user.id}
      end

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to qa_categories_path" do
        expect(response).to redirect_to(qa_categories_path)
      end

      it "assigns requested qa category as @qa_category" do
        expect(assigns(:qa_category)).to eq(qa_category)
      end

      it "should change qa category name" do
        expect(QaCategory.find(qa_category.id).name).to eq("Qa Category")
      end
    end

    context "with invalid params" do
      before do
        QaCategory.any_instance.should_receive(:update).and_return(false)
        patch :update, {qa_category: valid_attributes, id: qa_category.id}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "should not changed qa category name" do
        expect(QaCategory.find(qa_category.id).name).not_to eq("Qa Category")
      end
    end
  end

  describe "DELETE destroy" do
    context "with super user" do
      it "return http redirect" do
        delete :destroy, {id: qa_category.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to qa_categories_path" do
        delete :destroy, {id: qa_category.id}, {user: super_user.id}
        expect(response).to redirect_to(qa_categories_path)
      end

      it "destroys the requested qa category" do
        qa_category
        expect {
          delete :destroy, {id: qa_category.id}, {user: super_user.id}
          }.to change(QaCategory, :count).by(-1)
      end
    end

    context "with general user" do
      it "returns http not found" do
        delete :destroy, {id: qa_category.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST add_user" do
    context "with valid params" do
      it "return http redirect" do
        post :add_user, {id: qa_category.id, email: user.email}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to qa_category_path" do
        post :add_user, {id: qa_category.id, email: user.email}, {user: super_user.id}
        expect(response).to redirect_to(qa_category_path(qa_category))
      end

      it "destroys the requested affiliation" do
        expect {
          post :add_user, {id: qa_category.id, email: user.email}, {user: super_user.id}
          }.to change(QaCategory, :count).by(1)
      end
    end

    context "with answer_user already exists" do
      before do
        AnswerUser.should_receive(:exists?).and_return(true)
        post :add_user, {id: qa_category.id, email: user.email}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the show template" do
        expect(response).to render_template(:show)
      end
    end

    context "with user not found" do
      before do
        User.should_receive(:find_by!).and_raise(ActiveRecord::RecordNotFound)
        post :add_user, {id: qa_category.id, email: user.email}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the show template" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "DELETE del_user" do
    let!(:answer_user) {FactoryGirl.create(:answer_user)}

    it "return http redirect" do
      delete :del_user, {id: answer_user.qa_category_id, user_id: answer_user.user_id}, {user: super_user.id}
      expect(response).to be_redirect
    end

    it "should redirect to qa_category_path" do
      delete :del_user, {id: answer_user.qa_category_id, user_id: answer_user.user_id}, {user: super_user.id}
      expect(response).to redirect_to(qa_category_path(answer_user.qa_category))
    end

    it "destroys the requested answer_user" do
      expect {
        delete :del_user, {id: answer_user.qa_category_id, user_id: answer_user.user_id}, {user: super_user.id}
        }.to change(AnswerUser, :count).by(-1)
    end
  end
end
