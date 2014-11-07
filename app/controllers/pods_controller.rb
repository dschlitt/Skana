class PodsController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @pods = current_user.pods
    respond_with @pods
  end

  def show
    @pod = current_user.pods.with_deleted.find params[:id]

    if @pod.destroyed?
      pods = @pod.pool.pods
      @pod = pods.includes(:users).where('users.id' => current_user.id).first
      redirect_to @pod
    else
      respond_with @pod
    end
  end

  def leave
    current_user.pods.find(params[:pod_id]).destroy
    redirect_to :root
  end

  def messages_seen
    pod = Pod.find params[:pod_id]
    resource_view = ResourceView.where({ viewable: pod, user: current_user,
      resource_type: 'Message' }).first_or_create
    resource_view.update_attributes(last_viewed_at: Time.now)
    head :no_content
  end

end
