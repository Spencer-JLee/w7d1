class UsersController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only:[:index, :show]

  def index
    @users = User.all
    render :index
  end

  def show
    # debugger
    @user = User.find(params[:id])
    if @user
        render :show
    else
        render :index
    end
  end

  def new
    # debugger
    @user = User.new
    render :new
  end

  def create
    debugger
      @user = User.new(user_params)
      if @user.save
        redirect_to user_url(@user)
      else  
        render json: @user.errors.full_messages, status: 422
      end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

end