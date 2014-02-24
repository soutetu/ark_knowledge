require 'spec_helper'

describe Answer do
  describe "validations" do
    let(:answer) {FactoryGirl.build(:answer)}
    
    it "should valid with valid params" do
      expect(answer).to be_valid
    end

    it "should not valid if message is nil" do
      answer.message = nil
      expect(answer).not_to be_valid
    end

    it "should not valid if question_id is nil" do
      answer.question_id = nil
      expect(answer).not_to be_valid
    end
  end
end
