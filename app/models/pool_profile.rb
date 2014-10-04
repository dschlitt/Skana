class PoolProfile < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user

  def self.next (user, pool)
    seen_pool_profile_ids = user.seen_pool_profiles.where(pool: pool).ids

    seen_pool_profile_ids << user.pool_profiles.find_by(pool: pool).id

    pool_profile = pool.pool_profiles.where.not(id: seen_pool_profile_ids).first

    # Pop the current_user's pool_profile id to avoid matching with self.
    seen_pool_profile_ids.pop

    # May be nil -- if you're are the only person in the pool
    pool_profile || PoolProfile.find(seen_pool_profile_ids.first)
  end

end
