class MessagesController < WebsocketRails::BaseController

  def create

    if not authorize
      trigger_failure message: "unauthorize"
    else
      pod = Pod.find message[:pod_id]
      m = pod.messages.new
      m.user_id = current_user.id
      m.pod_id = message[:pod_id]
      m.text_body = ActionController::Base.helpers.sanitize(message[:text_body])

      channel = WebsocketRails["pod_#{pod.id}"]


      if m.save

        data = {
          name: current_user.name,
          pod_id: pod.id,
          text_body: message[:text_body],
          user_id: current_user.id
        }

        trigger_success message: "success"
        channel.trigger "messages.created", data
      else
        trigger_failure message: "save failed"
      end

    end
  end

  private

  def authorize
    pod_id = message[:pod_id]
    return user_signed_in? && current_user.pods.exists?(id: pod_id)
  end


end
