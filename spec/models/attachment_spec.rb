require 'spec_helper'

describe Attachment do
  let(:file_category) {FactoryGirl.create(:file_category)}
  let(:super_user) {FactoryGirl.create(:super_user)}

  describe "validations" do
    let(:attachment) {FactoryGirl.build(:attachment)}

    it "should valid with valid params" do
      expect(attachment).to be_valid
    end

    it "should not valid if orig_name is nil" do
      attachment.orig_name = nil
      expect(attachment).not_to be_valid
    end

    it "should not valid if orig_name is over 100 characters" do
      attachment.orig_name = "s" * 101
      expect(attachment).not_to be_valid
    end

    it "should not valid if content_type is nil" do
      attachment.content_type = nil
      expect(attachment).not_to be_valid
    end

    it "should not valid if content_type is over 50 characters" do
      attachment.content_type = "s" * 51
      expect(attachment).not_to be_valid
    end

    it "should not valid if file_category_id is nil" do
      attachment.file_category_id = nil
      expect(attachment).not_to be_valid
    end
  end

  describe "#path" do
    let(:attachment) {FactoryGirl.create(:attachment)}

    it "returns local file path" do
      expect(attachment.path).to eq(File.join(Rails.root.to_s, "files", "attachments", attachment.id.to_s))
    end
  end

  describe ".#new_file" do
    let(:attachment) {FactoryGirl.create(:attachment)}
    
    let(:att) do
      Attachment.new_file(
        fixture_file_upload("license.txt", "text/plain"),
        file_category,
        super_user
      )
    end

    it "returns Attachment object" do
      expect(att.is_a? Attachment).to be_true
    end

    it "returns valid object" do
      expect(att).to be_valid
    end

    it "should set specified parameter" do
      expect(att.orig_name).to eq("license.txt")
      expect(att.content_type).to eq("text/plain")
      expect(att.user_id).to eq(super_user.id)
      expect(att.file_category_id).to eq(file_category.id)
    end
  end
end
