require "spec_helper"

describe QuestionsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/qa_categories/1/questions").to route_to("questions#index", qa_category_id: "1")
    end

    it "routes to #new" do
      expect(get: "/qa_categories/1/questions/new").to route_to("questions#new", qa_category_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/questions/1/edit").to route_to("questions#edit", id: "1")
    end

    it "routes to #show" do
      expect(get: "/questions/1").to route_to("questions#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/qa_categories/1/questions").to route_to("questions#create", qa_category_id: "1")
    end

    it "routes to #update" do
      expect(put: "/questions/1").to route_to("questions#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/questions/1").to route_to("questions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/questions/1").to route_to("questions#destroy", id: "1")
    end

    it "routes to #answer" do
      expect(post: "/questions/1/answers").to route_to("questions#answer", id: "1")
    end

    it "routes to #unanswered" do
      expect(delete: "/questions/1/answers/1").to route_to("questions#unanswered", id: "1", answer_id: "1")
    end
  end
end
