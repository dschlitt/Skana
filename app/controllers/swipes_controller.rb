class SwipesController < ApplicationController

  before_action :authenticate_user!


  respond_to :js

  # accept a swipe
  # right_swipe, u
  def create


    # Accept the swipe

    swipe = current_user.swipes.where({
      seen_pool_profile_id: params[:seen_pool_profile_id],
      pool_id: params[:pool_id]
    }).first_or_initialize

    swipe.right_swipe = params[:right_swipe] == "true"
    swipe.count = swipe.count.present? ? swipe.count + 1 : 1
    swipe.save


    # Check if match
    other_profile = PoolProfile.find params[:seen_pool_profile_id]
    other_user = other_profile.user

    if swipe.right_swipe
      my_pool_profile = current_user.pool_profiles.find_by(pool_id: params[:pool_id])

      has_match = other_user.swipes.exists?(
        seen_pool_profile_id: my_pool_profile.id,
        right_swipe: true
      )

      # has match
      if has_match

        # check if they have pods
        pod = current_user.pods.find_by(pool_id: params[:pool_id])
        their_pod = other_user.pods.find_by(pool_id: params[:pool_id])

        new_pod = Pod.new(pool_id: params[:pool_id])


        if pod.present?
          pod.messages.update_all pod_id: new_pod.id
          new_pod.users << pod.users
          pod.destroy
        else
          new_pod.users << current_user
        end

        if their_pod.present?
          their_pod.messages.update_all pod_id: new_pod.id
          new_pod.users << their_pod.users
          their_pod.destroy
        else
          new_pod.users << other_user
        end

        new_pod.save

        result = new_pod.attributes

        puts "render match"
        render json: result.as_json

      else
        # don't have match

        @next_pp = PoolProfile.next(current_user, Pool.friendly.find(params[:pool_id]))
        puts "\n\n\n\n\n"
        puts "render next"
        puts "\n\n\n\n\n"
        render json: @next_pp
      end

    else

      @next_pp = PoolProfile.next(current_user, Pool.friendly.find(params[:pool_id]))
      puts "\n\n\n\n\n"
      puts "render next, swipe left"
      puts "\n\n\n\n\n"
      render json: @next_pp

    end


  end

end
