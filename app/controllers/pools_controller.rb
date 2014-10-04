class PoolsController < ApplicationController

  before_action :set_pool, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @pools = Pool.all
    respond_with @pools
  end

  def show
    respond_with @pool
  end

  def new
    @pool = Pool.new
    respond_with @pool
  end

  def create
    @pool = Pool.new pool_params
    flash[:notice] = 'Pool was successfully created.' if @pool.save
    respond_with @pool
  end

  def update
    flash[:notice] = 'Pool was successfully updated.' if @pool.save
    respond_with @pool
  end

  def edit
    respond_with @pool
  end

  def destroy
    @pool.destroy
    redirect_to :root 
  end

  private

  def set_pool
    @pool = Pool.find params[:pool_id]
  end

  def pool_params
    params.permit(:name, :name, :creator_id, :description, :start_at, 
                  :end_at, :location_name, :location_address)
  end

end
