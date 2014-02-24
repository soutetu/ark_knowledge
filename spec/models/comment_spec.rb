require 'spec_helper'

describe Comment do
  describe "validations" do
    let(:comment) {FactoryGirl.build(:comment)}
    
    it "should valid with valid params" do
      expect(comment).to be_valid
    end

    it "should not valid if message is nil" do
      comment.message = nil
      expect(comment).not_to be_valid
    end

    it "should not valid if board_id is nil" do
      comment.board_id = nil
      expect(comment).not_to be_valid
    end
  end
end
