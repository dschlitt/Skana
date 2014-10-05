class AuthorizationController < WebsocketRails::BaseController
  def authorize_channels
    # The channel name will be passed inside the message Hash
    #channel = WebsocketRails[message[:channel]]

    if true
      accept_channel current_user
    end

    #if channel.match(/pod_\d+/)
      #pod_id = channel.split("_"[0]);

      #if current_user && current_user.pods.exists?(id: pod_id)
        #accept_channel current_user
      #else
        #deny_channel({:message => 'authorization failed!'})
      #end

    #else
      #deny_channel(message: "Invalid channel")
    #end

  end
end
