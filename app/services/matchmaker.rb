module Matchmaker
  extend self

  def match(swipe, current_user)
    swiped_profile = PoolProfile.find swipe.seen_pool_profile_id
    swiped_user = swiped_profile.user

    if has_match?(current_user, swiped_user, swipe)

      # initialize new pod
      new_pod = Pod.new(pool_id: swipe.pool_id)

      # grab old pods
      my_pod = current_user.pods.find_by(pool_id: swipe.pool_id)
      swiped_user_pod = swiped_user.pods.find_by(pool_id: swipe.pool_id)

      # migrate to new pod
      migrate_to_new_pod(new_pod, my_pod, current_user, swiped_user_pod,
                          swiped_user)

      # save new pod
      new_pod.save

      # notify client of match
      notify_client(new_pod, my_pod, swiped_user_pod, current_user)

      # destroy old pods
      destroy_old_pods(my_pod, swiped_user_pod)

    end

  end

  private

    def has_match?(current_user, swiped_user, swipe)
      return false unless swipe.right_swipe
      my_profile = current_user.pool_profiles.find_by(pool_id: swipe.pool_id)
      swiped_user.swipes.exists?(
        seen_pool_profile_id: my_profile.id,
        right_swipe: true
      )
    end

    def migrate_to_new_pod(new_pod, my_pod, current_user, swiped_user_pod,
                            swiped_user)
        if my_pod.present?
          my_pod.messages.update_all pod_id: new_pod.id
          new_pod.users << my_pod.users
        else
          new_pod.users << current_user
        end

        if swiped_user_pod.present?
          swiped_user_pod.messages.update_all pod_id: new_pod.id
          new_pod.users << swiped_user_pod.users
        else
          new_pod.users << swiped_user
        end
    end

    def notify_client(new_pod, my_pod, swiped_user_pod, current_user)
      result = new_pod.attributes
      result["pool"] = new_pod.pool
      result["prev_ids"] = [my_pod.try(:id), swiped_user_pod.try(:id)]
      result["new_users"] = my_pod.try(:users) || [current_user]
      channel = WebsocketRails["pool_#{new_pod.pool.id}"]
      channel.trigger "matches.created", result.as_json
    end

    def destroy_old_pods(my_pod, swiped_user_pod)
      my_pod.try(:destroy)
      swiped_user_pod.try(:destroy)
    end

end
