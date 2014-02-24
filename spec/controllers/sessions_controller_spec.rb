require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST create" do
    let(:user) {FactoryGirl.create(:user)}

    context "with authentication failed" do
      before {post :create}

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the new template" do
        expect(response).to render_template(:new)
      end

      it "assigns nil as @user" do
        expect(assigns(:user)).to be_nil
      end
    end

    context "with authentication success" do
      before {post :create, {email: user.email, password: "secret"}}

      it "returns http redirect" do  
        expect(response).to be_redirect
      end

      it "should redirect to home_path" do
        expect(response).to redirect_to(home_path)
      end

      it "should set user id for session" do
        expect(session[:user]).not_to be_nil
      end

      it "assigns a user as @user" do
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe "GET destroy" do
    it "returns http redirect" do
      get :destroy
      expect(response).to be_redirect
    end

    it "should redirect to root_path" do
      get :destroy
      expect(response).to redirect_to(signin_path)
    end

    it "should clear session" do
      session[:user] = 1
      get :destroy
      expect(session[:user]).to be_nil
    end
  end
end
