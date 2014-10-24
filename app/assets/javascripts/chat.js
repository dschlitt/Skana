function chatService(eventAggregator, data, elements) {

  var userName    = data.userName,
      podId       = data.podId,
      messageData = data.messageData;

  var $messages   = elements.messages,
      $avatars    = elements.avatars,
      $form       = elements.form,
      $input      = elements.input;

  return {
    start: function() {
      initMessages();
      receiveMessages();
      sendMessages();
      handlePodMerge();
    }
  };

  function initMessages() {

    // add each message to DOM
    for (var i = 0; i < messageData.length; i++) {
      addMessage(messageData[i]);
    }

    // scroll to bottom of convo
    setTimeout(function() {
      $messages.animate({scrollTop: 10000});
    }, 0);

  }

  function receiveMessages() {
    eventAggregator.on('newMessage', function(data) {
      // only display messages from this pod
      if (podId === data.pod_id) {
        addMessage(data);
      }
    });
  }

  function sendMessages() {
    $form.submit(function(evt) {
      evt.preventDefault();
      eventAggregator.trigger(sendMessageData());
      $input.val('');
      $messages.animate({scrollTop: 10000});
    });
  }

  function handlePodMerge() {
    eventAggregator.on('newMatch', function(data) {
      if (podId === data.prev_ids[0] || podId === data.prev_ids[1]) {
        // change pod
        podId = data.id;
        // add avatar
        for (var i = 0; i < data.new_users.length; i++) {
          $avatars.append("<img src='" + data.new_users[i].avatar + "'>");
        }
      }
    });
  }

  function getColor(name) {
    var sum = 0;
    for (var i = 0; i < name.length - 1; i++) {
      sum += name.charCodeAt(i);
    }

    var h = sum % 16 * 16,
        s = 78 + name.length % 20 - 10,
        b = 30 + name.length % 10 - 5;
    var color = tinycolor({h: h, s: s, l: b});

    return color.toHexString();
  }

  function addMessage(data) {
    var name = data.name || "Anon" + data.user_id;
    var color = getColor(name);
    var text = stripTags(data.text_body);

    $messages.append(
      "<p>" + "<span class='name' style='color:" + color + ";'>" + name +
      "</span>" + "<span class='body'>" + text + "</span>" + "</p>"
    );
  }

  function sendMessageData() {
    return {
      type: 'sendMessage',
      pod_id: podId,
      text_body: $input.val(),
      name: userName
    };
  }

}
