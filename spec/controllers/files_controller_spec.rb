require 'spec_helper'

describe FilesController do
  let(:attachment) {FactoryGirl.create(:attachment)}
  let(:file_category) {FactoryGirl.create(:file_category)}
  let(:user) {FactoryGirl.create(:user)}
  let(:super_user) {FactoryGirl.create(:super_user)}

  describe "GET index" do
    before {get :index, {file_category_id: file_category.id}, {user: user.id}}

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns requested file category as @file_category" do
      expect(assigns(:file_category)).to eq(file_category)
    end
  end

  describe "GET show" do
    it "returns http success" do
      controller.stub(:render)
      controller.should_receive(:send_file)
      get :show, {id: attachment.id}, {user: user.id}
      expect(response).to be_success
    end
  end

  describe "POST create" do
    let!(:file) {fixture_file_upload("license.txt", "text/plain")}
    let(:fp) {double("File Mock").as_null_object}

    before {File.stub(:open).and_return(fp)}

    context "with save success" do
      it "returns http redirect" do
        post :create, {file_category_id: file_category.id, attachment: file}, {user: user.id}
        expect(response).to be_redirect
      end

      it "should redirect to file_category_files_path" do
        post :create, {file_category_id: file_category.id, attachment: file}, {user: user.id}
        expect(response).to redirect_to(file_category_files_path(file_category))
      end

      it "create new file" do
        fp.should_receive(:write)
        expect {
          post :create, {file_category_id: file_category.id, attachment: file}, {user: user.id}
          }.to change(Attachment, :count).by(1)
      end

      it "should close file" do
        fp.should_receive(:close)
        post :create, {file_category_id: file_category.id, attachment: file}, {user: user.id}
      end
    end

    context "with save failed" do
      before {Attachment.any_instance.should_receive(:save!).and_raise}

      it "returns http success" do
        post :create, {file_category_id: file_category.id, attachment: file}, {user: user.id}
        expect(response).to be_success
      end

      it "re-renders the index template" do
        post :create, {file_category_id: file_category.id, attachment: file}, {user: user.id}
        expect(response).to render_template(:index)
      end
    end
  end

  describe "DELETE destroy" do
    before {FileUtils.stub(:rm)}

    context "with owner" do
      it "returns http redirect" do
        delete :destroy, {id: attachment.id}, {user: attachment.user.id}
        expect(response).to be_redirect
      end

      it "should redirect to file_category_files_path" do
        delete :destroy, {id: attachment.id}, {user: attachment.user.id}
        expect(response).to redirect_to(file_category_files_path(attachment.file_category))
      end

      it "should delete requested file" do
        attachment
        FileUtils.should_receive(:rm)
        expect {
          delete :destroy, {id: attachment.id}, {user: attachment.user.id}
          }.to change(Attachment, :count).by(-1)
      end
    end

    context "with super user" do
      it "returns http redirect" do
        delete :destroy, {id: attachment.id}, {user: super_user.id}
        expect(response).to be_redirect
      end

      it "should redirect to file_category_files_path" do
        delete :destroy, {id: attachment.id}, {user: super_user.id}
        expect(response).to redirect_to(file_category_files_path(attachment.file_category))
      end

      it "should delete requested file" do
        attachment
        FileUtils.should_receive(:rm)
        expect {
          delete :destroy, {id: attachment.id}, {user: super_user.id}
          }.to change(Attachment, :count).by(-1)
      end
    end

    context "with generic user" do
      it "returns http not found" do
        delete :destroy, {id: attachment.id}, {user: user.id}
        expect(response.status).to eq(404)
      end
    end
  end
end
