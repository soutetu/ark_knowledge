require "spec_helper"

describe BoardCategoriesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/board_categories/1/boards").to route_to("boards#index", board_category_id: "1")
    end

    it "routes to #new" do
      expect(get: "/board_categories/1/boards/new").to route_to("boards#new", board_category_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/boards/1/edit").to route_to("boards#edit", id: "1")
    end

    it "routes to #show" do
      expect(get: "/boards/1").to route_to("boards#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/board_categories/1/boards").to route_to("boards#create", board_category_id: "1")
    end

    it "routes to #update" do
      expect(put: "/boards/1").to route_to("boards#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/boards/1").to route_to("boards#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/boards/1").to route_to("boards#destroy", id: "1")
    end

    it "routes to #comment" do
      expect(post: "/boards/1/comments").to route_to("boards#comment", id: "1")
    end

    it "routes to #uncomment" do
      expect(delete: "/boards/1/comments/1").to route_to("boards#uncomment", id: "1", comment_id: "1")
    end
  end
end
