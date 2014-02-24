require "spec_helper"

describe ApplicationController do
  let(:user) {FactoryGirl.create(:user)}

  describe "#require_signin" do
    controller do
      before_action :require_signin
      def index
        render nothing: true
      end
    end

    it "returns http success" do
      get :index, {}, {user: user.id}
      expect(response).to be_success
    end

    it "returns http redirect if not signin" do
      get :index
      expect(response).to be_redirect
    end

    it "should redirect to signin_path if not signin" do
      get :index
      expect(response).to redirect_to(signin_path)
    end
  end

  describe "#current_user" do
    controller do
      before_action :current_user
      def index
        render nothing: true
      end
    end

    it "should return user" do
      get :index, {}, {user: user.id}
      expect(assigns(:current_user)).to eq(user)
    end

    it "should return nil if not signin" do
      get :index
      expect(assigns(:current_user)).to be_nil
    end
  end

  describe "#require_super_user" do
    let(:super_user) {FactoryGirl.create(:super_user)}

    context "with require_signin" do
      controller do
        before_action :require_signin
        before_action :require_super_user
        def index
          @proc = true
          render nothing: true
        end
      end

      it "returns http success" do
        get :index, {}, {user: super_user.id}
        expect(response).to be_success
      end

      it "returns http not found if not super user" do
        get :index, {}, {user: user.id}
        expect(response.status).to eq(404)
      end

      it "should not defined assigns if not super user" do
        get :index, {}, {user: user.id}
        expect(assigns(:proc)).to be_nil
      end
    end
  end
end