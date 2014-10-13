function webSocketManager(url, current_page) {
  var dispatcher = new WebSocketRails(url + '/websocket');

  return {
    matchNotifier: function(channelList) {

      // Listen for match on each pool
      for (var i = 0; i < channelList.length; i++) {
        listenOnPoolChannel(channelList[i]);
      }

    },
    messageNotifier: function(channelList) {

      // Listen for new message on each pod
      for (var i = 0; i < channelList.length; i++) {
        listenOnPodChannel(channelList[i]);
      }

    }
  };

  function messageSuccess(data) {
    // emit event to be handled as needed
    $('body').trigger('newMessage', data);
  }

  function matchSuccess(data) {
    // start listening to new chat channel
    listenOnPodChannel(data.id);
    // emit event to be handled as needed
    $('body').trigger('newMatch', data);
  }

  function listenOnPodChannel(pod_id) {
    var channel = dispatcher.subscribe_private('pod_' + pod_id);
    channel.bind('messages.created', messageSuccess);
  }

  function listenOnPoolChannel(pool_id) {
    var channel = dispatcher.subscribe_private('pool_' + pool_id);
    channel.bind('matches.created', matchSuccess);
  }

}
