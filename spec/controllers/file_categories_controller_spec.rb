require 'spec_helper'

describe FileCategoriesController do
  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}
  let(:file_category) {FactoryGirl.create(:file_category)}
  let(:valid_attributes) {{name: "File Category"}}

  describe "GET index" do
    before do
      file_category
      get :index, {}, {user: user.id}
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns file categories as @file_categories" do
      expect(assigns(:file_categories)).to eq([file_category])
    end
  end

  describe "GET new" do
    context "with super user" do
      before {get :new, {}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns a new file category as @file_category" do
        expect(assigns(:file_category)).to be_a_new(FileCategory)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        get :new, {}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET edit" do
    context "with super user" do
      it "returns http success" do
        get :edit, {id: file_category.id}, {user: super_user.id}
        expect(response).to be_success
      end
    end

    context "with generic user" do
      it "returns http not found" do
        get :edit, {id: file_category.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new FileCategory" do
        expect {
          post :create, {file_category: valid_attributes}, {user: super_user.id}
        }.to change(FileCategory, :count).by(1)
      end

      it "returns http redirect" do
        post :create, {file_category: valid_attributes}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to file_categories_path" do
        post :create, {file_category: valid_attributes}, {user: super_user.id}
        expect(response).to redirect_to(file_categories_path)
      end

      it "assigns a newly created file category as @file_category" do
        post :create, {file_category: valid_attributes}, {user: super_user.id}
        expect(assigns(:file_category)).to be_a(FileCategory)
        expect(assigns(:file_category)).to be_persisted
      end
    end

    context "with invalid params" do
      before do
        FileCategory.any_instance.should_receive(:save).and_return(false)
      end

      it "returns http success" do
        post :create, {file_category: valid_attributes}, {user: super_user.id}
        expect(response).to be_success
      end

      it "re-renders the new template" do
        post :create, {file_category: valid_attributes}, {user: super_user.id}
        expect(response).to render_template(:new)
      end

      it "don't create a new file category" do
        expect {
          post :create, {file_category: valid_attributes}, {user: super_user.id}
          }.not_to change(FileCategory, :count)
        expect(assigns(:file_category)).to be_a_new(FileCategory)
      end
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      before {patch :update, {file_category: valid_attributes, id: file_category.id}, {user: super_user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to file_categories_path" do
        expect(response).to redirect_to(file_categories_path)
      end

      it "assigns requested file_category as @file_category" do
        expect(assigns(:file_category)).to eq(file_category)
      end

      it "should change category name" do
        expect(FileCategory.find(file_category.id).name).to eq("File Category")
      end
    end

    context "with invalid params" do
      before do
        FileCategory.any_instance.should_receive(:update).and_return(false)
        patch :update, {file_category: valid_attributes, id: file_category.id}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "should not changed category name" do
        expect(FileCategory.find(file_category.id).name).not_to eq("File Category")
      end
    end
  end

  describe "DELETE destroy" do
    context "with super user" do
      it "return http redirect" do
        delete :destroy, {id: file_category.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to file_categories_path" do
        delete :destroy, {id: file_category.id}, {user: super_user.id}
        expect(response).to redirect_to(file_categories_path)
      end

      it "destroys the requested file_category" do
        file_category
        expect {
          delete :destroy, {id: file_category.id}, {user: super_user.id}
          }.to change(FileCategory, :count).by(-1)
      end
    end

    context "with general user" do
      it "returns http not found" do
        delete :destroy, {id: file_category.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end
end
