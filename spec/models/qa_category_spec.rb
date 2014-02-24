require 'spec_helper'

describe QaCategory do
  describe "validations" do
    let(:qa_category) {FactoryGirl.build(:qa_category)}
    
    it "should valid with valid params" do
      expect(qa_category).to be_valid
    end

    it "should not valid if name is nil" do
      qa_category.name = nil
      expect(qa_category).not_to be_valid
    end

    it "should not valid if name is over 30 characters" do
      qa_category.name = "s" * 31
      expect(qa_category).not_to be_valid
    end

    it "should not valid if description is over 100 characters" do
      qa_category.description = "s" * 101
      expect(qa_category).not_to be_valid
    end
  end

  describe "#category_manager?" do
    let(:user) {FactoryGirl.create(:user)}
    let(:qa_category) {FactoryGirl.create(:qa_category)}

    before do
      AnswerUser.create!(user_id: user.id, qa_category_id: qa_category.id)
    end

    it "returns true if manager" do
      expect(qa_category.category_manager? user).to be_true
    end

    it "returns true if not manager" do
      expect(qa_category.category_manager? FactoryGirl.create(:user)).to be_false
    end
  end
end
