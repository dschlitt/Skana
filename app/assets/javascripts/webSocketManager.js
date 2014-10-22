function webSocketManager(url, eventAggregator) {

  var dispatcher = new WebSocketRails(url + '/websocket');

  eventAggregator.on('sendMessage', sendMessageSuccess);

  function listenOnPodChannel(pod_id) {
    var channel = dispatcher.subscribe_private('pod_' + pod_id);
    channel.bind('messages.created', newMessageSuccess);
  }

  function listenOnPoolChannel(pool_id) {
    var channel = dispatcher.subscribe_private('pool_' + pool_id);
    channel.bind('matches.created', newMatchSuccess);
  }

  function sendMessageSuccess(data) {
    dispatcher.trigger('messages.create', messageData(data));
  }

  function newMessageSuccess(data) {
    eventAggregator.trigger(messageData(data));
  }

  function newMatchSuccess(data) {
    listenOnPodChannel(data.id);
    eventAggregator.trigger(matchData(data));
  }

  function messageData(data) {
    return {
      type: 'newMessage',
      pod_id: data.pod_id,
      name: data.name,
      text_body: data.text_body,
      user_id: data.user_id,
    };
  }

  function matchData(data) {
    return {
      type: 'newMatch',
      id: data.id,
      prev_ids: data.prev_ids,
      new_users: data.new_users,
      pool_id: data.pool_id,
      pool: data.pool
    };
  }

  return {

    matchListener: function(channelList) {
      for (var i = 0; i < channelList.length; i++) {
        listenOnPoolChannel(channelList[i]);
      }
    },

    messageListener: function(channelList) {
      for (var i = 0; i < channelList.length; i++) {
        listenOnPodChannel(channelList[i]);
      }
    }

  };

}
