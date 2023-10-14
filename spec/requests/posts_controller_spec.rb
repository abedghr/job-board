# spec/controllers/api/admin_posts_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::AdminPostsController, type: :controller do
  let(:user) { user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: "admin") } # Assuming you have a user factory
  let(:post_params) { { title: 'Test Post', description: 'This is a test post' } }

  before do
    secret_key = Rails.application.config_for(:params)['jwt_secret_key']
    payload = { user_id: user.id, exp: 1.hour.from_now.to_i }
    jwt_token = JWT.encode(payload, secret_key, 'HS256')
    request.headers['Authorization'] = "Bearer #{jwt_token}"
  end

  describe "POST #create" do
    it "returns a success response when valid parameters are provided" do
      post :create, params: post_params
      expect(response).to have_http_status(:created)
    end

    it "returns an error response with invalid parameters" do
      invalid_post_params = { title: '', description: '' }
      post :create, params: invalid_post_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end
