require 'spec_helper'

describe RootController do
  describe "GET index" do
    let(:user) {FactoryGirl.create(:user)}

    context "with not signin" do
      it "returns http success" do
        get :index
        expect(response).to be_success
      end
    end

    context "with signin" do
      before {get :index, {}, {user: user.id}}

      it "returns http redirect if already signin" do
        expect(response).to be_redirect
      end

      it "should redirect to home_path if already signin" do
        expect(response).to redirect_to(home_path)
      end
    end
  end
end
