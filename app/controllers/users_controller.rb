class UsersController < ApplicationController
  #before_action :find_user, only: [:]
  #skip_before_action :verify_authenticity_token
  # tuto https://ahtantech.wordpress.com/2017/10/18/simple-ruby-on-rails-api-postman/
  def index
    users = User.all
    render json: users
  end

  def show
   user = User.find(params[:id])
   render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :last)
  end
end
