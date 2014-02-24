require 'spec_helper'

describe Board do
  let(:user) {FactoryGirl.create(:user)}
  let(:board_category) {FactoryGirl.create(:board_category)}
  let(:valid_attributes) {{title: "Topic", body: "Knowledge"}}

  describe "validations" do
    let(:board) {FactoryGirl.build(:board)}

    it "should valid with valid params" do
      expect(board).to be_valid
    end

    it "should not valid if title is nil" do
      board.title = nil
      expect(board).not_to be_valid
    end

    it "should not valid if title is over 40 characters" do
      board.title = "s" * 41
      expect(board).not_to be_valid
    end

    it "should not valid if body is nil" do
      board.body = nil
      expect(board).not_to be_valid
    end

    it "should not valid if board_category_id is nil" do
      board.board_category_id = nil
      expect(board).not_to be_valid
    end
  end

  describe ".#new_topic" do
    let(:board) {FactoryGirl.create(:board)}
    let(:topic) {Board.new_topic(valid_attributes, board_category, user)}

    it "returns Board object" do
      expect(topic.is_a? Board).to be_true
    end

    it "returns valid object" do
      expect(topic).to be_valid
    end

    it "should set specified parameter" do
      expect(topic.title).to eq("Topic")
      expect(topic.body).to eq("Knowledge")
      expect(topic.user_id).to eq(user.id)
      expect(topic.board_category_id).to eq(board_category.id)
    end
  end
end
