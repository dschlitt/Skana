class PoolProfileSerializer < ActiveModel::Serializer
  attributes :id, :goals, :skills, :pod_members

  has_one :user

  def pod_members
    puts "hello"
    pod = object.user.pods.find_by(pool_id: object.pool.id)
    if pod && pod.users
      pod.users.where.not(id: object.user.id).pluck :avatar
    end
  end

end
