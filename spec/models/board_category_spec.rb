require 'spec_helper'

describe BoardCategory do
  describe "validations" do
    let(:board_category) {FactoryGirl.build(:board_category)}
    
    it "should valid with valid params" do
      expect(board_category).to be_valid
    end

    it "should not valid if name is nil" do
      board_category.name = nil
      expect(board_category).not_to be_valid
    end

    it "should not valid if name is over 30 characters" do
      board_category.name = "s" * 31
      expect(board_category).not_to be_valid
    end

    it "should not valid if description is over 100 characters" do
      board_category.description = "s" * 101
      expect(board_category).not_to be_valid
    end
  end
end
