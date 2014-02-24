require 'spec_helper'

describe Affiliation do
  describe "validations" do
    let(:affiliation) {FactoryGirl.build(:affiliation)}
    
    it "should valid with valid params" do
      expect(affiliation).to be_valid
    end

    it "should not valid if user_id is nil" do
      affiliation.user_id = nil
      expect(affiliation).not_to be_valid
    end

    it "should not valid if group_id is nil" do
      affiliation.group_id = nil
      expect(affiliation).not_to be_valid
    end

    it "should not valid if duplicated" do
      duplicate = FactoryGirl.create(:affiliation)
      affiliation.group_id = duplicate.group_id
      affiliation.user_id = duplicate.user_id
      expect(affiliation).not_to be_valid
    end
  end
end
