require 'spec_helper'

describe BoardsController do
  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}
  let(:board_category) {FactoryGirl.create(:board_category)}
  let(:board) {FactoryGirl.create(:board, user: user, board_category: board_category)}
  let(:comment) {FactoryGirl.create(:comment, user: user, board: board)}
  let(:valid_attributes) {{title: "Topic", body: "Knowledge"}}

  describe "GET index" do
    before {get :index, {board_category_id: board_category.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested board category as @board_category" do
      expect(assigns(:board_category)).to eq(board_category)
    end
  end

  describe "GET new" do
    before {get :new, {board_category_id: board_category.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested board category as @board_category" do
      expect(assigns(:board_category)).to eq(board_category)
    end

    it "assigns a new board as @board" do
      expect(assigns(:board)).to be_a_new(Board)
    end
  end

  describe "GET show" do
    before {get :show, {id: board.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested board as @board" do
      expect(assigns(:board)).to eq(board)
    end
  end

  describe "GET edit" do
    context "with owner" do
      before {get :edit, {id: board.id}, {user: user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested board as @board" do
        expect(assigns(:board)).to eq(board)
      end
    end

    context "with super user" do
      before {get :edit, {id: board.id}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested board as @board" do
        expect(assigns(:board)).to eq(board)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        get :edit, {id: board.id}, {user: FactoryGirl.create(:user).id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    it "create new board" do
      expect {
        post :create, {board_category_id: board_category.id, board: valid_attributes}, {user: user.id}
        }.to change(Board, :count).by(1)
    end

    context "with success" do
      before {post :create, {board_category_id: board_category.id, board: valid_attributes}, {user: user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to board_category_boards_path" do
        expect(response).to redirect_to(board_category_boards_path(board_category))
      end

      it "assigns requested board category as @board_category" do
        expect(assigns(:board_category)).to eq(board_category)
      end
    end

    context "with failed" do
      before do
        Board.any_instance.should_receive(:save).and_return(false)
        post :create, {board_category_id: board_category.id, board: valid_attributes}, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH update" do
    context "with success" do
      before {patch :update, {id: board.id, board: valid_attributes}, {user: user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to board_path" do
        expect(response).to redirect_to(board_path(board))
      end

      it "assigns requested board as @board" do
        expect(assigns(:board)).to eq(board)
      end

      it "should change requested board" do
        expect(Board.last.title).to eq("Topic")
      end
    end

    context "with failed" do
      before do
        Board.any_instance.should_receive(:update).and_return(false)
        patch :update, {id: board.id, board: valid_attributes}, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    context "with owner" do
      it "returns http redirect" do
        delete :destroy, {id: board.id}, {user: user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_category_boards_path" do
        delete :destroy, {id: board.id}, {user: user.id}
        expect(response).to redirect_to(board_category_boards_path(board_category))
      end

      it "delete requested board" do
        board
        expect {
          delete :destroy, {id: board.id}, {user: user.id}
          }.to change(Board, :count).by(-1)
      end
    end

    context "with super user" do
      it "returns http redirect" do
        delete :destroy, {id: board.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_category_boards_path" do
        delete :destroy, {id: board.id}, {user: super_user.id}
        expect(response).to redirect_to(board_category_boards_path(board_category))
      end

      it "delete requested board" do
        board
        expect {
          delete :destroy, {id: board.id}, {user: super_user.id}
          }.to change(Board, :count).by(-1)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        delete :destroy, {id: board.id}, {user: FactoryGirl.create(:user).id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST comment" do
    context "with success" do
      it "returns http redirect" do
        post :comment, {id: board.id, message: "Some"}, {user: user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_path" do
        post :comment, {id: board.id, message: "Some"}, {user: user.id}
        expect(response).to redirect_to(board_path(board))
      end

      it "assigns requested board as @board" do
        post :comment, {id: board.id, message: "Some"}, {user: user.id}
        expect(assigns(:board)).to eq(board)
      end

      it "create a new comment" do
        expect {
          post :comment, {id: board.id, message: "Some"}, {user: user.id}
          }.to change(Comment, :count).by(1)
      end
    end

    context "with failed" do
      before do
        Comment.any_instance.should_receive(:save).and_return(false)
        post :comment, {id: board.id, message: "Some"}, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the show template" do
        expect(response).to render_template(:show)
      end

      it "assigns requested message as @message" do
        expect(assigns(:message)).to eq("Some")
      end
    end
  end

  describe "DELETE uncomment" do
    context "with owner" do
      it "returns http redirect" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_path" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: user.id}
        expect(response).to redirect_to(board_path(board))
      end

      it "assigns requested board as @board" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: user.id}
        expect(assigns(:board)).to eq(board)
      end

      it "delete a requested comment" do
        comment
        expect {
          delete :uncomment, {id: board.id, comment_id: comment.id}, {user: user.id}
          }.to change(Comment, :count).by(-1)
      end
    end

    context "with super user" do
      it "returns http redirect" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to board_path" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: super_user.id}
        expect(response).to redirect_to(board_path(board))
      end

      it "assigns requested board as @board" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: super_user.id}
        expect(assigns(:board)).to eq(board)
      end

      it "delete requested comment" do
        comment
        expect {
          delete :uncomment, {id: board.id, comment_id: comment.id}, {user: super_user.id}
          }.to change(Comment, :count).by(-1)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        delete :uncomment, {id: board.id, comment_id: comment.id}, {user: FactoryGirl.create(:user).id}
        expect(response.status).to eq(404)
      end
    end
  end
end
