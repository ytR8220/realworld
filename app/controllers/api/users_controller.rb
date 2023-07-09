class Api::UsersController < ApplicationController
  before_action :authorize, only: [:index, :current, :destroy, :update]

  def index
    @users = User.all
    render json: @users, status: :ok
  end
  
  def create
    @user = User.create(user_params)
    
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: { 
        user: { 
          email: @user.email, 
          token: @token, 
          username: @user.username, 
          bio: @user.bio, 
          image: @user.image
        } 
      }, status: :created
    else
      render json: {error: "Invalid username or password"}, status: :unprocessible_entity
    end
  end
  
  def login
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: { 
        user: { 
          email: @user.email, 
          token: @token, 
          username: @user.username, 
          bio: @user.bio, 
          image: @user.image
        } 
      }, status: :ok
    else
      render json: {error: "Invalid username or password"}, status: :unprocessible_entity
    end
  end

  def current
    render json: { 
      user: { 
        email: @user.email, 
        token: @token, 
        username: @user.username, 
        bio: @user.bio, 
        image: @user.image
      } 
    }, status: :ok
  end

  def update
    @user = User.find_by(email: user_params[:email])
    @user.update(user_params)
    render json: { 
      user: { 
        email: @user.email, 
        token: @token, 
        username: @user.username, 
        bio: @user.bio, 
        image: @user.image
      } 
    }, status: :ok
  end

  def destroy
    @user.destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image)
  end

end
