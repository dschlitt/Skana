class SwipesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_swipe_and_pool

  respond_to :js

  def create # accept a swipe

    # update swipe attributes
    @swipe.right_swipe = params[:right_swipe] == "true"
    @swipe.count = @swipe.count.present? ? @swipe.count + 1 : 1
    @swipe.save

    # run swipe matching workflow (notifies client if match found)
    Matchmaker.match(@swipe, current_user)

    # render next pool profile
    @next_pp = PoolProfile.next(current_user, @pool)
    render json: @next_pp

  end

  private

    def set_swipe_and_pool
      set_swipe
      set_pool
    end

    def set_swipe
      @swipe = current_user.swipes.where({
        seen_pool_profile_id: params[:seen_pool_profile_id],
        pool_id: params[:pool_id]
      }).first_or_initialize
    end

    def set_pool
      @pool = Pool.find(@swipe.pool_id)
    end

end
