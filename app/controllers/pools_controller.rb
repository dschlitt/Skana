class PoolsController < ApplicationController

  before_action :set_pool, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!, except: :show

  respond_to :html

  def index
    @pools = Pool.all
    respond_with @pools
  end

  def show
    if !user_signed_in?
      store_location_for :user, pool_path(@pool)
    end
    respond_with @pool
  end

  def new
    @pool = Pool.new
    respond_with @pool
  end

  def create
    @pool = Pool.new pool_params
    @pool.creator_id = current_user.id
    flash[:notice] = 'Pool was successfully created.' if @pool.save
    #respond_with @pool
    redirect_to :root
  end

  def update
    @pool.update pool_params
    respond_with @pool
  end

  def edit
    respond_with @pool
  end

  def destroy
    @pool.destroy
    redirect_to :root
  end

  def match
    @pool = current_user.pools.friendly.find params[:pool_id]
    @next_pp = PoolProfile.next(current_user, @pool)
  end

  private

  def set_pool
    @pool = Pool.friendly.find params[:id]
  end

  def pool_params
    params.require(:pool).permit(:name, :description, :start_at, 
                  :end_at, :location_name, :location_address)
  end

end
