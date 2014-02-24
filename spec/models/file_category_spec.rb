require 'spec_helper'

describe FileCategory do
  describe "validations" do
    let(:file_category) {FactoryGirl.build(:file_category)}

    it "should valid with valid params" do
      expect(file_category).to be_valid
    end

    it "should not valid if name is nil" do
      file_category.name = nil
      expect(file_category).not_to be_valid
    end

    it "should not valid if name is over 30 characters" do
      file_category.name = "s" * 31
      expect(file_category).not_to be_valid
    end

    it "should not valid if description is over 100 characters" do
      file_category.description = "s" * 101
      expect(file_category).not_to be_valid
    end
  end
end
