class PoolProfile < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user

  def self.next (user, pool)

    blacklist = user.swipes.where(pool: pool).pluck(:seen_pool_profile_id)

    blacklist << user.pool_profiles.find_by(pool: pool).id

    pool_profile = pool.pool_profiles.where.not(id: blacklist).first

    # Pop the current_user's pool_profile id to avoid matching with self.
    gray_list = user.swipes.where(pool: pool, right_swipe: false).pluck(:seen_pool_profile_id)

    # May be nil -- if you're are the only person in the pool
    pool_profile || PoolProfile.find_by(id: gray_list.first)
  end

end
