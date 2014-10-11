module Matchmaker
  extend self

  def match(swipe, current_user)
    render_value = nil

    swiped_profile = PoolProfile.find swipe.seen_pool_profile_id
    swiped_user = swiped_profile.user

    if swipe.right_swipe # If current_user swiped right on swiped user
      my_pool_profile = current_user.pool_profiles.find_by(pool_id: swipe.pool_id)

      has_match = swiped_user.swipes.exists?(
        seen_pool_profile_id: my_pool_profile.id,
        right_swipe: true
      )

      if has_match # if swiped_user also swiped right on current_user

        # grab matched pods
        my_pod = current_user.pods.find_by(pool_id: swipe.pool_id)
        swiped_user_pod = swiped_user.pods.find_by(pool_id: swipe.pool_id)

        # move to new pod
        new_pod = Pod.new(pool_id: swipe.pool_id)

        if my_pod.present?
          my_pod.messages.update_all pool_id: new_pod.id
          new_pod.users << my_pod.users
          pod.destroy
        else
          new_pod.users << current_user
        end

        if swiped_user_pod.present?
          swiped_user_pod.messages.update_all pod_id: new_pod.id
          new_pod.users << swiped_user_pod.users
          swiped_user_pod.destroy
        else
          new_pod.users << swiped_user
        end

        # save new pod
        new_pod.save

        #respond to client
        result = new_pod.attributes
        puts "render match"
        render_value = result.as_json

      else # does not have match

        @next_pp = PoolProfile.next(current_user, Pool.find(swipe.pool_id))
        puts "\n\n\n\n\n"
        puts "render next"
        puts "\n\n\n\n\n"
        render_value = @next_pp

      end

    else

      @next_pp = PoolProfile.next(current_user, Pool.find(swipe.pool_id))
      puts "\n\n\n\n\n"
      puts "render next, swipe left"
      puts "\n\n\n\n\n"
      render_value = @next_pp

    end

    render_value
  end
end
