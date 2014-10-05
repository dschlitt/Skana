class PoolProfilesController < ApplicationController

  before_action :authenticate_user!

  before_action :set_pool
  before_action :set_pool_profile, only: [:show, :update, :edit, :destroy]

  respond_to :html

  def show
    respond_with @pool_profile
  end

  def new
    @pool_profile = @pool.pool_profiles.new
    respond_with @pool_profile
  end

  def create
    @pool_profile = @pool.pool_profiles.new pool_profile_params
    @pool_profile.user_id = current_user.id
    flash[:notice] = 'Pool Profile was successfully created.' if @pool_profile.save
    #respond_with @pool_profile
    #Redirect to Match?
  end

  def update
    if @pool_profile.update pool_profile_params
      flash[:notice] = 'Pool Profile was successfully updated.'
    end
    respond_with @pool_profile
  end

  def edit
    respond_with @pool_profile
  end

  def destroy
    @pool_profile.destroy
    redirect_to :root
  end

  private

  def set_pool
    @pool = Pool.find params[:pool_id]
  end

  def set_pool_profile
    @pool_profile = @pool.pool_profiles.find params[:id]
  end

  def pool_profile_params
    params.permit(:goals, :skills)
  end

end
