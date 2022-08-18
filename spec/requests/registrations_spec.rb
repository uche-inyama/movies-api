require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "POST /registrations" do
    let!(:valid_params) do {
      user: {
        email: Faker::Internet.email, 
        username: Faker::Name.first_name, 
        password:  'password', 
        password_confirmation: 'password' 
      }
    } end

    let!(:invalid_params) do {
      user: {
        email: Faker::Internet.email,
        username: "",
        password: "",
        password_confirmation: "",
      }
    } end 

    it "Successfully creates a user with valid params" do
      post '/users', params: valid_params
      expect(response).to have_http_status(200)
    end

    it "fails to create a user with invalid params" do
      post '/users', params: invalid_params
      expect(JSON.parse(response.body)).to include("unprocessable_entity")
    end
  end
end
