require 'spec_helper'

describe Question do
  describe "validations" do
    let(:question) {FactoryGirl.build(:question)}

    it "should valid with valid params" do
      expect(question).to be_valid
    end

    it "should not valid if title is nil" do
      question.title = nil
      expect(question).not_to be_valid
    end

    it "should not valid if title is over 40 characters" do
      question.title = "s" * 41
      expect(question).not_to be_valid
    end

    it "should not valid if body is nil" do
      question.body = nil
      expect(question).not_to be_valid
    end

    it "should not valid if status is nil" do
      question.status = nil
      expect(question).not_to be_valid
    end

    it "should not valid if status is unknown value" do
      question.status = "unknown"
      expect(question).not_to be_valid
    end

    it "should not valid if replay_deadline is nil" do
      question.replay_deadline = nil
      expect(question).not_to be_valid
    end

    it "should not valid if replay_deadline is unknown value" do
      question.replay_deadline = "unknown"
      expect(question).not_to be_valid
    end

    it "should not valid if qa_category_id is nil" do
      question.qa_category_id = nil
      expect(question).not_to be_valid
    end
  end

  describe ".#new_question" do
    let(:user) {FactoryGirl.create(:user)}
    let(:qa_category) {FactoryGirl.create(:qa_category)}
    let(:valid_attributes) {{title: "Question", body: "Some Question", status: "新規", replay_deadline: "至急"}}
    let(:question) {Question.new_question(valid_attributes, qa_category, user)}

    it "returns Board object" do
      expect(question.is_a? Question).to be_true
    end

    it "returns valid object" do
      expect(question).to be_valid
    end

    it "should set specified parameter" do
      expect(question.title).to eq("Question")
      expect(question.body).to eq("Some Question")
      expect(question.status).to eq("新規")
      expect(question.replay_deadline).to eq("至急")
      expect(question.user_id).to eq(user.id)
      expect(question.qa_category_id).to eq(qa_category.id)
    end
  end
end
