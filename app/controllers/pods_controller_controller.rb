class PodsControllerController < ApplicationController

  before_action :authenticate_user!

  respond_to :html

  def index
    @pods = current_user.pods
    respond_with @pods
  end

  def show
    @pod = current_user.pods.find params[:pod_id]
    respond_with @pod
  end

end
