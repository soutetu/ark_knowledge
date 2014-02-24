require "spec_helper"

describe NoticeMailer do
  let(:user) {FactoryGirl.create(:user)}
  let(:question) {FactoryGirl.create(:question)}

  describe "register" do
    let(:mail) {NoticeMailer.register(user, "secret")}

    it "renders the headers" do
      expect(mail.subject).to eq("ユーザ登録")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["test@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.fullname)
      expect(mail.body.encoded).to match("secret")
    end
  end

  describe "new_question" do
    before do
      AnswerUser.create!(user_id: user.id, qa_category_id: question.qa_category_id)
    end

    let(:mail) {NoticeMailer.new_question(question)}

    it "renders the headers" do
      expect(mail.subject).to eq("質問が投稿されました")
      expect(mail.to).to eq([user.email, question.user.email])
      expect(mail.from).to eq(["test@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(question.replay_deadline)
      expect(mail.body.encoded).to match(question.user.fullname)
      expect(mail.body.encoded).to match(question.title)
    end
  end

  describe "update_question" do
    before do
      AnswerUser.create!(user_id: user.id, qa_category_id: question.qa_category_id)
    end

    let(:mail) {NoticeMailer.update_question(question, user)}

    it "renders the headers" do
      expect(mail.subject).to eq("質問が更新されました")
      expect(mail.to).to eq([user.email, question.user.email])
      expect(mail.from).to eq(["test@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.fullname)
      expect(mail.body.encoded).to match(question.user.fullname)
      expect(mail.body.encoded).to match(question.title)
    end
  end

  describe "delete_question" do
    before do
      AnswerUser.create!(user_id: user.id, qa_category_id: question.qa_category_id)
    end

    let(:mail) {NoticeMailer.delete_question(question, user)}

    it "renders the headers" do
      expect(mail.subject).to eq("質問が削除されました")
      expect(mail.to).to eq([user.email, question.user.email])
      expect(mail.from).to eq(["test@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(user.fullname)
      expect(mail.body.encoded).to match(question.user.fullname)
      expect(mail.body.encoded).to match(question.title)
    end
  end
end
