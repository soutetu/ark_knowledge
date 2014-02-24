require 'spec_helper'

describe QuestionsController do
  let(:user) {FactoryGirl.create(:user)}
  let(:manager) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}
  let(:qa_category) {FactoryGirl.create(:qa_category)}
  let(:question) {FactoryGirl.create(:question, user: user, qa_category: qa_category)}
  let(:valid_attributes) {{title: "Question", body: "Some Question", status: "新規", replay_deadline: "至急"}}

  describe "GET index" do
    before {get :index, {qa_category_id: qa_category.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested qa category as @qa_category" do
      expect(assigns(:qa_category)).to eq(qa_category)
    end
  end

  describe "GET show" do
    before {get :show, {id: question.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested question as @question" do
      expect(assigns(:question)).to eq(question)
    end
  end

  describe "GET new" do
    before {get :new, {qa_category_id: qa_category.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested qa category as @qa_category" do
      expect(assigns(:qa_category)).to eq(qa_category)
    end

    it "assigns a new question as @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe "GET edit" do
    context "with owner" do
      before {get :edit, {id: question.id}, {user: user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested question as @question" do
        expect(assigns(:question)).to eq(question)
      end
    end

    context "with manager" do
      before do
        AnswerUser.create(qa_category_id: qa_category.id, user_id: manager.id)
      end

      before {get :edit, {id: question.id}, {user: manager.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested question as @question" do
        expect(assigns(:question)).to eq(question)
      end
    end

    context "with super user" do
      before {get :edit, {id: question.id}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested question as @question" do
        expect(assigns(:question)).to eq(question)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        get :edit, {id: question.id}, {user: FactoryGirl.create(:user).id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    before {NoticeMailer.stub(:new_question).and_return(double.as_null_object)}

    it "create new question" do
      expect {
        post :create, {qa_category_id: qa_category.id, question: valid_attributes}, {user: user.id}
        }.to change(Question, :count).by(1)
    end

    context "with success" do
      before {post :create, {qa_category_id: qa_category.id, question: valid_attributes}, {user: user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to qa_category_questions_path" do
        expect(response).to redirect_to(qa_category_questions_path(qa_category))
      end

      it "assigns requested qa category as @qa_category" do
        expect(assigns(:qa_category)).to eq(qa_category)
      end
    end

    context "with failed" do
      before do
        Question.any_instance.should_receive(:save).and_return(false)
        post :create, {qa_category_id: qa_category.id, question: valid_attributes}, {user: user.id}
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
    before {NoticeMailer.stub(:update_question).and_return(double.as_null_object)}

    context "with success" do
      before {patch :update, {id: question.id, question: valid_attributes}, {user: user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to question_path" do
        expect(response).to redirect_to(question_path(question))
      end

      it "assigns requested question as @question" do
        expect(assigns(:question)).to eq(question)
      end

      it "should change requested question" do
        expect(Question.last.title).to eq("Question")
      end
    end

    context "with failed" do
      before do
        Question.any_instance.should_receive(:update).and_return(false)
        patch :update, {id: question.id, question: valid_attributes}, {user: user.id}
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
    before {NoticeMailer.stub(:delete_question).and_return(double.as_null_object)}

    context "with owner" do
      it "returns http redirect" do
        delete :destroy, {id: question.id}, {user: user.id}
        expect(response).to be_redirect
      end

      it "should redirect to qa_category_questions_path" do
        delete :destroy, {id: question.id}, {user: user.id}
        expect(response).to redirect_to(qa_category_questions_path(qa_category))
      end

      it "delete requested question" do
        question
        expect {
          delete :destroy, {id: question.id}, {user: user.id}
          }.to change(Question, :count).by(-1)
      end
    end

    context "with category manager" do
      before do
        AnswerUser.create(qa_category_id: qa_category.id, user_id: manager.id)
      end

      it "returns http redirect" do
        delete :destroy, {id: question.id}, {user: manager.id}
        expect(response).to be_redirect
      end

      it "should redirect to qa_category_questions_path" do
        delete :destroy, {id: question.id}, {user: manager.id}
        expect(response).to redirect_to(qa_category_questions_path(qa_category))
      end

      it "delete requested question" do
        question
        expect {
          delete :destroy, {id: question.id}, {user: manager.id}
          }.to change(Question, :count).by(-1)
      end
    end

    context "with super user" do
      it "returns http redirect" do
        delete :destroy, {id: question.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to qa_category_questions_path" do
        delete :destroy, {id: question.id}, {user: super_user.id}
        expect(response).to redirect_to(qa_category_questions_path(qa_category))
      end

      it "delete requested question" do
        question
        expect {
          delete :destroy, {id: question.id}, {user: super_user.id}
          }.to change(Question, :count).by(-1)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        delete :destroy, {id: question.id}, {user: FactoryGirl.create(:user).id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST answer" do
    context "with success" do
      it "returns http redirect" do
        post :answer, {id: question.id, message: "Some"}, {user: user.id}
        expect(response).to be_redirect
      end

      it "should redirect to question_path" do
        post :answer, {id: question.id, message: "Some"}, {user: user.id}
        expect(response).to redirect_to(question_path(question))
      end

      it "assigns requested question as @question" do
        post :answer, {id: question.id, message: "Some"}, {user: user.id}
        expect(assigns(:question)).to eq(question)
      end

      it "create a new answer" do
        expect {
          post :answer, {id: question.id, message: "Some"}, {user: user.id}
          }.to change(Answer, :count).by(1)
      end
    end

    context "with failed" do
      before do
        Answer.any_instance.should_receive(:save).and_return(false)
        post :answer, {id: question.id, message: "Some"}, {user: user.id}
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

  describe "DELETE unanswered" do
    let(:answer_user) {FactoryGirl.create(:user)}
    let(:answer) {FactoryGirl.create(:answer, question: question, user: answer_user)}

    context "with owner" do
      it "returns http redirect" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: answer_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to question_path" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: answer_user.id}
        expect(response).to redirect_to(question_path(question))
      end

      it "assigns requested question as @question" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: answer_user.id}
        expect(assigns(:question)).to eq(question)
      end

      it "delete a requested answer" do
        answer
        expect {
          delete :unanswered, {id: question.id, answer_id: answer.id}, {user: answer_user.id}
          }.to change(Answer, :count).by(-1)
      end
    end

    context "with super user" do
      it "returns http redirect" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to question_path" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: super_user.id}
        expect(response).to redirect_to(question_path(question))
      end

      it "assigns requested question as @question" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: super_user.id}
        expect(assigns(:question)).to eq(question)
      end

      it "delete requested answer" do
        answer
        expect {
          delete :unanswered, {id: question.id, answer_id: answer.id}, {user: super_user.id}
          }.to change(Answer, :count).by(-1)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        delete :unanswered, {id: question.id, answer_id: answer.id}, {user: FactoryGirl.create(:user).id}
        expect(response.status).to eq(404)
      end
    end
  end
end
