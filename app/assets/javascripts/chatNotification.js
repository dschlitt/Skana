function chatNotificationService(eventAggregator, initNewMessageCount, $elem) {

  var newMessageCount = initNewMessageCount;

  eventAggregator.on('newMessage', updateNewMessageNotification);

  return {
    start: function() {
      initNewMessageNotification();
    },
    stop: function() {
      stopNewMessageNotification();
    },
    clear: function() {
      clearNewMessageNotification();
    }
  };

  function initNewMessageNotification() {
    if ($elem) {
      if (newMessageCount === 0) {
        $elem.addClass('hidden');
      } else if (newMessageCount > 0) {
        $elem.removeClass('hidden');
      }
    }
  }

  function updateNewMessageNotification() {
    newMessageCount++;
    initNewMessageNotification();
    $elem.text(newMessageCount);
  }

  function stopNewMessageNotification() {
    eventAggregator.off('newMessage', updateNewMessageNotification);
  }

  function clearNewMessageNotification() {
    newMessageCount = 0;
    initNewMessageNotification();
    $elem.text(newMessageCount);
  }

}
