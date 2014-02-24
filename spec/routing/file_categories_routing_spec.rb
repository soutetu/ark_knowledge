require "spec_helper"

describe FileCategoriesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/file_categories").to route_to("file_categories#index")
    end

    it "routes to #new" do
      expect(get: "/file_categories/new").to route_to("file_categories#new")
    end

    it "routes to #edit" do
      expect(get: "/file_categories/1/edit").to route_to("file_categories#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/file_categories").to route_to("file_categories#create")
    end

    it "routes to #update" do
      expect(put: "/file_categories/1").to route_to("file_categories#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/file_categories/1").to route_to("file_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/file_categories/1").to route_to("file_categories#destroy", id: "1")
    end
  end
end
