require 'spec_helper'

describe GroupsController do
  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}
  let(:group) {FactoryGirl.create(:group)}
  let(:valid_attributes) {{name: "Group"}}

  describe "GET index" do
    before do
      group
      get :index, {}, {user: user.id}
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns all groups as @groups" do
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe "GET show" do
    before {get :show, {id: group.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns the requested group as @group" do
      expect(assigns(:group)).to eq(group)
    end
  end

  describe "GET new" do
    context "with super user" do
      before {get :new, {}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns a new group as @group" do
        expect(assigns(:group)).to be_a_new(Group)
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
      before {get :edit, {id: group.id}, {user: super_user.id}}

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns requested group as @group" do
        expect(assigns(:group)).to eq(group)
      end
    end

    context "with general user" do
      before {get :edit, {id: group.id}, {user: user.id}}

      it "returns http not found" do
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Group" do
        expect {
          post :create, {group: valid_attributes}, {user: super_user.id}
        }.to change(Group, :count).by(1)
      end

      it "returns http redirect" do
        post :create, {group: valid_attributes}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to group_path" do
        post :create, {group: valid_attributes}, {user: super_user.id}
        expect(response).to redirect_to(group_path(Group.last))
      end

      it "assigns a newly created group as @group" do
        post :create, {group: valid_attributes}, {user: super_user.id}
        expect(assigns(:group)).to be_a(Group)
        expect(assigns(:group)).to be_persisted
      end
    end

    context "with invalid params" do
      before do
        Group.any_instance.should_receive(:save).and_return(false)
      end

      it "returns http success" do
        post :create, {group: valid_attributes}, {user: super_user.id}
        expect(response).to be_success
      end

      it "re-renders the new template" do
        post :create, {group: valid_attributes}, {user: super_user.id}
        expect(response).to render_template(:new)
      end

      it "don't create a new group" do
        expect {
          post :create, {group: valid_attributes}, {user: super_user.id}
          }.not_to change(Group, :count)
        expect(assigns(:group)).to be_a_new(Group)
      end
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      before {patch :update, {group: valid_attributes, id: group.id}, {user: super_user.id}}

      it "returns http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to group_path" do
        expect(response).to redirect_to(group_path(group))
      end

      it "assigns requested group as @group" do
        expect(assigns(:group)).to eq(group)
      end

      it "should change group name" do
        expect(Group.find(group.id).name).to eq("Group")
      end
    end

    context "with invalid params" do
      before do
        Group.any_instance.should_receive(:update).and_return(false)
        patch :update, {group: valid_attributes, id: group.id}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "should not changed group name" do
        expect(Group.find(group.id).name).not_to eq("Group")
      end
    end
  end

  describe "DELETE destroy" do
    context "with super user" do
      it "return http redirect" do
        delete :destroy, {id: group.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to groups_path" do
        delete :destroy, {id: group.id}, {user: super_user.id}
        expect(response).to redirect_to(groups_path)
      end

      it "destroys the requested group" do
        group
        super_user
        expect {
          delete :destroy, {id: group.id}, {user: super_user.id}
          }.to change(Group, :count).by(-1)
      end
    end

    context "with general user" do
      it "returns http not found" do
        delete :destroy, {id: group.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "POST add_user" do
    context "with valid params" do
      it "return http redirect" do
        post :add_user, {id: group.id, email: user.email}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to group_path" do
        post :add_user, {id: group.id, email: user.email}, {user: super_user.id}
        expect(response).to redirect_to(group_path(group))
      end

      it "destroys the requested affiliation" do
        expect {
          post :add_user, {id: group.id, email: user.email}, {user: super_user.id}
          }.to change(Affiliation, :count).by(1)
      end
    end

    context "with affiliation already exists" do
      before do
        Affiliation.should_receive(:exists?).and_return(true)
        post :add_user, {id: group.id, email: user.email}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the show template" do
        expect(response).to render_template(:show)
      end
    end

    context "with user not found" do
      before do
        User.should_receive(:find_by!).and_raise(ActiveRecord::RecordNotFound)
        post :add_user, {id: group.id, email: user.email}, {user: super_user.id}
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "re-renders the show template" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "DELETE del_user" do
    let!(:affiliation) {FactoryGirl.create(:affiliation)}

    it "return http redirect" do
      delete :del_user, {id: affiliation.group_id, user_id: affiliation.user_id}, {user: super_user.id}
      expect(response).to be_redirect
    end

    it "should redirect to group_path" do
      delete :del_user, {id: affiliation.group_id, user_id: affiliation.user_id}, {user: super_user.id}
      expect(response).to redirect_to(group_path(affiliation.group))
    end

    it "destroys the requested affiliation" do
      expect {
        delete :del_user, {id: affiliation.group_id, user_id: affiliation.user_id}, {user: super_user.id}
        }.to change(Affiliation, :count).by(-1)
    end
  end
end
