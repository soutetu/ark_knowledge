require 'spec_helper'

describe AnswerUser do
  describe "validations" do
    let(:answer_user) {FactoryGirl.build(:answer_user)}
    
    it "should valid with valid params" do
      expect(answer_user).to be_valid
    end

    it "should not valid if user_id is nil" do
      answer_user.user_id = nil
      expect(answer_user).not_to be_valid
    end

    it "should not valid if qa_category_id is nil" do
      answer_user.qa_category_id = nil
      expect(answer_user).not_to be_valid
    end

    it "should not valid if duplicated" do
      duplicate = FactoryGirl.create(:answer_user)
      answer_user.qa_category_id = duplicate.qa_category_id
      answer_user.user_id = duplicate.user_id
      expect(answer_user).not_to be_valid
    end
  end
end
