require 'spec_helper'

describe UsersController do
  def valid_attributes
    {
      first_name: "first",
      last_name: "last",
      first_name_kana: "first_kana",
      last_name_kana: "last_kana",
      email: "user@example.com",
      role: 0
      }
  end

  def valid_password
    {old_password: "secret", new_password: "secret01", new_password_confirmation: "secret01"}
  end

  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}

  describe "GET index" do
    before do
      user
      get :index, {}, {user: user.id}
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns users as @users" do
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET show" do
    before {get :show, {id: user.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested user as @user" do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET new" do
    context "with super user" do
      before {get :new, {}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns a new user as @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
    end

    context "with general user" do
      before {get :new, {}, {user: user.id}}

      it "returns http not found" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET edit" do
    context "with super user" do
      before {get :edit, {id: user.id}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested user as @user" do
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with general user" do
      before {get :edit, {id: user.id}, {user: user.id}}

      it "returns http not found" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      before {NoticeMailer.stub(:register).and_return(double.as_null_object)}

      it "returns http redirect" do
        post :create, {user: valid_attributes}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to signin_path" do
        post :create, {user: valid_attributes}, {user: super_user.id}
        expect(response).to redirect_to(users_path)
      end

      it "create a new user" do
        super_user
        expect {
          post :create, {user: valid_attributes}, {user: super_user.id}
          }.to change(User, :count).by(1)
      end
    end

    context "with invalid params" do
      before do
        super_user
        User.any_instance.should_receive(:save!).and_raise
      end

      it "returns http success" do
        post :create, {user: valid_attributes}, {user: super_user.id}
        expect(response).to be_success
      end

      it "re-renders the new template" do
        post :create, {user: valid_attributes}, {user: super_user.id}
        expect(response).to render_template(:new)
      end

      it "don't create a new user" do
        expect {
          post :create, {user: valid_attributes}, {user: super_user.id}
          }.not_to change(User, :count)
      end
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      before {patch :update, {user: valid_attributes, id: user.id}, {user: super_user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to profile_path" do
        expect(response).to redirect_to(users_path)
      end

      it "should change user name" do
        expect(User.find(user.id).first_name).to eq("first")
      end
    end

    context "with invalid params" do
      before do
        User.any_instance.should_receive(:update).and_return(false)
        patch :update, {user: valid_attributes, id: user.id}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "should not changed user name" do
        expect(User.find(user.id).first_name).not_to eq("first")
      end
    end
  end

  describe "DELETE destroy" do
    it "return http redirect" do
      delete :destroy, {id: user.id}, {user: super_user.id}
      expect(response).to be_redirect
    end

    it "should redirect to users_path" do
      delete :destroy, {id: user.id}, {user: super_user.id}
      expect(response).to redirect_to(users_path)
    end

    it "delete requested user" do
      user
      super_user
      expect {
        delete :destroy, {id: user.id}, {user: super_user.id}
        }.to change(User, :count).by(-1)
    end
  end

  describe "GET search" do
    before {get :search, {keyword: user.first_name_kana}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested keyword as @keyword" do
      expect(assigns(:keyword)).to eq(user.first_name_kana)
    end

    it "assigns users as @users" do
      expect(assigns(:users)).to eq([user])
    end

    it "render the index template" do
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET home" do
    it "returns http success" do
      get :home, {}, {user: user.id}
      expect(response).to be_success
    end
  end

  describe "GET profile" do
    it "returns http success" do
      get :profile, {}, {user: user.id}
      expect(response).to be_success
    end
  end

  describe "PATCH update_profile" do
    context "with valid params" do
      before {patch :update_profile, {user: {first_name: "changed"}}, {user: user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to profile_path" do
        expect(response).to redirect_to(profile_path)
      end

      it "should change user name" do
        expect(User.last.first_name).to eq("changed")
      end
    end

    context "with invalid params" do
      before do
        User.any_instance.should_receive(:update).and_return(false)
        patch :update_profile, {user: {first_name: "changed"}}, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the profile template" do
        expect(response).to render_template(:profile)
      end

      it "should not changed user name" do
        expect(User.last.first_name).not_to eq("changed")
      end
    end
  end

  describe "PATCH update_password" do
    context "with valid password" do
      before {patch :update_password, valid_password, {user: user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to signin_path" do
        expect(response).to redirect_to(signin_path)
      end

      it "should clear session" do
        expect(session[:user]).to be_nil
      end

      it "should change password" do
        expect(User.last.password).not_to eq(default_password)
      end
    end

    context "with password not match" do
      before do
        Passwd.should_receive(:confirm_check).and_raise(Passwd::PasswordNotMatch)
        patch :update_password, valid_password, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the profile template" do
        expect(response).to render_template(:profile)
      end

      it "should not change password" do
        expect(User.last.password).to eq(default_password)
      end
    end

    context "with authentication fails" do
      before do
        User.any_instance.should_receive(:update_password).and_raise(Passwd::AuthError)
        patch :update_password, valid_password, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the profile template" do
        expect(response).to render_template(:profile)
      end

      it "should not change password" do
        expect(User.last.password).to eq(default_password)
      end
    end

    context "with policy not match" do
      before do
        User.any_instance.should_receive(:update_password).and_raise(Passwd::PolicyNotMatch)
        patch :update_password, valid_password, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the profile template" do
        expect(response).to render_template(:profile)
      end

      it "should not change password" do
        expect(User.last.password).to eq(default_password)
      end
    end

    context "with update fails" do
      before do
        user
        User.any_instance.should_receive(:save!).and_raise(RuntimeError)
        patch :update_password, valid_password, {user: user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the profile template" do
        expect(response).to render_template(:profile)
      end

      it "should not change password" do
        expect(User.last.password).to eq(default_password)
      end
    end
  end
end
