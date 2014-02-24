require "spec_helper"

describe BoardCategoriesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/board_categories").to route_to("board_categories#index")
    end

    it "routes to #new" do
      expect(get: "/board_categories/new").to route_to("board_categories#new")
    end

    it "routes to #edit" do
      expect(get: "/board_categories/1/edit").to route_to("board_categories#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/board_categories").to route_to("board_categories#create")
    end

    it "routes to #update" do
      expect(put: "/board_categories/1").to route_to("board_categories#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/board_categories/1").to route_to("board_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/board_categories/1").to route_to("board_categories#destroy", id: "1")
    end
  end
end
