require "spec_helper"

describe FileCategoriesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/file_categories/1/files").to route_to("files#index", file_category_id: "1")
    end

    it "routes to #show" do
      expect(get: "/files/1").to route_to("files#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/file_categories/1/files").to route_to("files#create", file_category_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/files/1").to route_to("files#destroy", id: "1")
    end
  end
end