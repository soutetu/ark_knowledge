require 'spec_helper'

describe BoardCategoriesController do
  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}
  let(:board_category) {FactoryGirl.create(:board_category)}
  let(:valid_attributes) {{name: "Board Category"}}

  describe "GET index" do
    before do
      board_category
      get :index, {}, {user: user.id}
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns all board categories as @board_categories" do
      expect(assigns(:board_categories)).to eq([board_category])
    end
  end

  describe "GET new" do
    context "with super user" do
      before {get :new, {}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns a new board category as @board_category" do
        expect(assigns(:board_category)).to be_a_new(BoardCategory)
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
        get :edit, {id: board_category.id}, {user: super_user.id}
        expect(response).to be_success
      end
    end

    context "with generic user" do
      it "returns http not found" do
        get :edit, {id: board_category.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new BoardCategory" do
        expect {
          post :create, {board_category: valid_attributes}, {user: super_user.id}
        }.to change(BoardCategory, :count).by(1)
      end

      it "returns http redirect" do
        post :create, {board_category: valid_attributes}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_categories_path" do
        post :create, {board_category: valid_attributes}, {user: super_user.id}
        expect(response).to redirect_to(board_categories_path)
      end

      it "assigns a newly created board category as @board_category" do
        post :create, {board_category: valid_attributes}, {user: super_user.id}
        assigns(:board_category).should be_a(BoardCategory)
        assigns(:board_category).should be_persisted
      end
    end

    context "with invalid params" do
      before do
        BoardCategory.any_instance.should_receive(:save).and_return(false)
      end

      it "returns http success" do
        post :create, {board_category: valid_attributes}, {user: super_user.id}
        expect(response).to be_success
      end

      it "re-renders the new template" do
        post :create, {board_category: valid_attributes}, {user: super_user.id}
        expect(response).to render_template(:new)
      end

      it "don't create a new board category" do
        expect {
          post :create, {board_category: valid_attributes}, {user: super_user.id}
          }.not_to change(BoardCategory, :count)
        expect(assigns(:board_category)).to be_a_new(BoardCategory)
      end
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      before do
        patch :update, {board_category: valid_attributes, id: board_category.id}, {user: super_user.id}
      end

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to board_categories_path" do
        expect(response).to redirect_to(board_categories_path)
      end

      it "assigns requested board_category as @board_category" do
        expect(assigns(:board_category)).to eq(board_category)
      end

      it "should change category name" do
        expect(BoardCategory.find(board_category.id).name).to eq("Board Category")
      end
    end

    context "with invalid params" do
      before do
        BoardCategory.any_instance.should_receive(:update).and_return(false)
        patch :update, {board_category: valid_attributes, id: board_category.id}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "should not changed category name" do
        expect(BoardCategory.find(board_category.id).name).not_to eq("Board Category")
      end
    end
  end

  describe "DELETE destroy" do
    context "with super user" do
      it "return http redirect" do
        delete :destroy, {id: board_category.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_categories_path" do
        delete :destroy, {id: board_category.id}, {user: super_user.id}
        expect(response).to redirect_to(board_categories_path)
      end

      it "destroys the requested board_category" do
        board_category
        expect {
          delete :destroy, {id: board_category.id}, {user: super_user.id}
          }.to change(BoardCategory, :count).by(-1)
      end
    end

    context "with general user" do
      it "returns http not found" do
        delete :destroy, {id: board_category.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end
end
