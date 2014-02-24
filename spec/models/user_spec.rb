require "spec_helper"

describe User do
  let(:super_user) {FactoryGirl.create(:super_user)}

  describe "validations" do
    let(:user) {FactoryGirl.build(:user)}

    it "should valid with valid params" do
      expect(user).to be_valid
    end

    it "should not valid if first_name is nil" do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it "should not valid if first_name is over 20 characters" do
      user.first_name = "s" * 21
      expect(user).not_to be_valid
    end

    it "should not valid if last_name is nil" do
      user.last_name = nil
      expect(user).not_to be_valid
    end

    it "should not valid if last_name is over 20 characters" do
      user.last_name = "s" * 21
      expect(user).not_to be_valid
    end

    it "should not valid if first_name_kana is nil" do
      user.first_name_kana = nil
      expect(user).not_to be_valid
    end

    it "should not valid if first_name_kana is over 40 characters" do
      user.first_name_kana = "s" * 41
      expect(user).not_to be_valid
    end

    it "should not valid if last_name_kana is nil" do
      user.last_name_kana = nil
      expect(user).not_to be_valid
    end

    it "should not valid if last_name_kana is over 40 characters" do
      user.last_name_kana = "s" * 41
      expect(user).not_to be_valid
    end

    it "should not valid if email is nil" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "should not valid if email is over 100 characters" do
      user.email = "s" * 101
      expect(user).not_to be_valid
    end

    it "should not valid if role is not inclusion 0..1" do
      user.role = 3
      expect(user).not_to be_valid
    end
  end

  describe "#super_user?" do
    let(:user) {FactoryGirl.create(:user)}

    it "returns true if super user" do
      expect(super_user.super_user?).to be_true
    end

    it "returns false if not super user" do
      expect(user.super_user?).to be_false
    end
  end

  describe "#fullname" do
    let(:user) {FactoryGirl.create(:user)}

    it "returns fullname" do
      expect(user.fullname).to eq([user.last_name, user.first_name].join(" "))
    end
  end

  describe "#fullname_kana" do
    let(:user) {FactoryGirl.create(:user)}

    it "returns fullname kana" do
      expect(user.fullname_kana).to eq([user.last_name_kana, user.first_name_kana].join(" "))
    end
  end

  describe ".#new_user" do
    let(:user) do
      User.new_user({
        first_name: "first",
        last_name: "last",
        first_name_kana: "first_kana",
        last_name_kana: "last_kana",
        email: "user@example.com",
        role: 0
        })
    end

    it "returns user and password" do
      expect(user.size).to eq(2)
      expect(user.first.is_a? User).to be_true
      expect(user.last.is_a? String).to be_true
    end
  end
end
