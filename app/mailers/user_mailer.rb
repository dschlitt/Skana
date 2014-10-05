class UserMailer < ActionMailer::Base
  default :from => skanatestsender@gmail.com

  def new_pod_memeber(existing_members, new_members, pool)
    @new_member = new_members
    @pool = pool
    existing_members_email = existing_members.pluck :email
    mail(:to => existing_members_email, :subject => "New Member in One of Your Skana Pods")
 
end
