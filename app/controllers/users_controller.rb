class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :edit, :destroy]

  respond_to :html

  #def index
    #@users = User.all
    #respond_with @users
  #end

  def show
    respond_with @user
  end

  #def new
    #@user = User.new
    #respond_with @user
  #end

  #def create
    #@user = User.new user_params
    #flash[:notice] = 'User was successfully created.' if @user.save
    #respond_with @user
  #end

  def update
    flash[:notice] = 'User was successfully updated.' if @user.save
    respond_with @user
  end

  def edit
    respond_with @user
  end

  def destroy
    @user.destroy
    redirect_to :root
  end

  private

  def set_user
    @user = params[:id] ? User.find(params[:user_id]) : current_user
  end

  def user_params
    params.permit(:name)
  end

end
