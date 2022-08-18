require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /sessions" do
    let!(:user) { create(:user) }
    let(:valid_params) do {
      user: {
        email: user.email,
        password: user.password
      }
    } end

    it "Successfully signs in user" do
      post "/users/sign_in", params: valid_params

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to include("token")
      expect(JSON.parse(response.body)).to include("current_user")
    end

    it "fails to sign in a user when password is missing" do
      post '/users/sign_in', params: {user: { email: user.email, password: ''}}
      expect(JSON.parse(response.body)).to include({"error" => "unauthorized"})
    end

    it "fails to sign in a user when email is missing" do
      post '/users/sign_in', params: { user: {email: '', password: user.password} }
      expect(JSON.parse(response.body)).to include({"error" => "unauthorized"})
    end
  end
end
