require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #new" do
    it "renders the new template" do
      get "/users/new"
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post "/users", params: { user: { password: "asdfjkl"} }
        expect(response).to render_template(:new)

        post "/users", params: { user: { email: "asdfjklei"}}
        expect(response).to render_template(:new)
      end

      it "validates that the password is at least 6 characters long" do
        post "/users", params: { user: { email: "asdfjklq", password: "asdf"} }
        expect(response).to render_template(:new)
      end
    end

    context "with valid params" do
      it "render check email page" do
        post "/users", params: { user: { email: "asdfjkl", password: "qweruiop" } }
        expect(response).to render_template(:check_email_page)
      end
    end
  end
end