require 'rails_helper'

RSpec.describe Api::TokenController, type: :controller do
  describe "POST #register" do
    it "returns a success response" do
      user_params = { email: 'admin@gmail.com', password: 'password', password_confirmation: 'password' }
      post :register, params: {
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
      }
      expect(response).to have_http_status(:created)
    end

    it "returns an error response with invalid data" do
      user_params = { email: 'invalid-email', password: 'short', password_confirmation: 'mismatch' }
      post :register, params: { user: user_params }
      expect(response).to have_http_status(:unprocessable_entity)
      # Add more expectations as needed
    end
  end
  

  describe "POST #login" do
    it "returns a success response with valid login credentials" do
      user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: "job_seeker")
      post :login, params: { email: user.email, password: 'password' }
      expect(response).to have_http_status(:ok)
      # Add more expectations as needed
    end

    it "returns an unauthorized response with invalid login credentials" do
      user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: "job_seeker")
      post :login, params: { email: user.email, password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
      # Add more expectations as needed
    end
  end
end
