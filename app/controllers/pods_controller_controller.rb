class PodsControllerController < ApplicationController

  before_action :authenticate_user!

  respond_to :html

  def index
    @pods = current_user.pods
    respond_with @pods
  end

  def show
    @pod = current_user.pods.find params[:id]
    respond_with @pod
  end

  def leave
    current.pods.find(params[:id]).destroy
    redirect :root
  end

end
