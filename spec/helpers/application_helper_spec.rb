require "spec_helper"

describe ApplicationHelper do
  describe "#view_role" do
    let(:user) {FactoryGirl.create(:user)}
    let(:super_user) {FactoryGirl.create(:super_user)}

    it "should return administrator if super user" do
      expect(helper.view_role(super_user)).to eq("管理者")
    end

    it "should return general if not super user" do
      expect(helper.view_role(user)).to eq("一般")
    end
  end

  describe "#abbreviation" do
    let(:small_text) {"01234"}
    let(:large_text) {"012345678901234"}

    it "should returns as it is" do
      expect(helper.abbreviation(small_text)).to eq(small_text)
    end

    it "should returns abbreviation" do
      expect(helper.abbreviation(large_text)).to eq(large_text.slice(0, 10) + "...")
    end
  end

  describe "#time_format" do
    let(:time) {Time.new(2013, 10, 26, 12, 13, 14)}

    it "should returns string of time" do
      expect(helper.time_format(time)).to eq(time.strftime("%Y/%m/%d %H:%M:%S"))
    end
  end

  describe "#markdown" do
    let(:text) {"#hello"}

    it "should returns string of html" do
      expect(helper.markdown(text).chomp).to eq("<h1>hello</h1>")
    end
  end
end