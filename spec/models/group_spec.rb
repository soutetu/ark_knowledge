require 'spec_helper'

describe Group do
  describe "validations" do
    let(:group) {FactoryGirl.build(:group)}

    it "should valid with valid params" do
      expect(group).to be_valid
    end

    it "should not valid if name is nil" do
      group.name = nil
      expect(group).not_to be_valid
    end

    it "should not valid if name is over 30 characters" do
      group.name = "s" * 31
      expect(group).not_to be_valid
    end

    it "should not valid if description is over 100 characters" do
      group.description = "s" * 101
      expect(group).not_to be_valid
    end
  end
end
