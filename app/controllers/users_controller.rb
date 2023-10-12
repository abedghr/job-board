class UsersController < ApplicationController
  # def create
  #   if user_params[:email].blank?
  #     render json: { errors: ["Email is required"] }, status: :unprocessable_entity
  #     return
  #   end

  #   if user_params[:password].blank?
  #     render json: { errors: ["Password is required"] }, status: :unprocessable_entity
  #     return
  #   end

  #   @user = User.new(user_params)
  #   @user.role = "job_seeker"
  #   if @user.save
  #     render json: @user, status: :created
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    if params[:registration]
      register_user
    else
      login_user
    end
  end

  def register_user
    @user = User.new(user_params)
    @user.role = 'job_seeker'

    if @user.save
      token = encode_token(@user.id)
      render json: { auth_token: token }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login_user
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { auth_token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def encode_token(user_id)
    payload = { user_id: user_id }
    secret_key = "b8bd58d7f46c0dc5ab46b90fc75eb23f8dd7c032c51c98c163a0c234f8a253b397248cb754b92e0a1a75cc3d644a5500a8734b753cc93436ab4a00fa0b56951c"
    JWT.encode(payload, secret_key, 'HS256')
  end
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
