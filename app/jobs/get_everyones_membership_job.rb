class GetEveryonesMembershipJob < ApplicationJob
  queue_as :default

  def perform(user)
    return if user.name == "Server"
    @room_membership = Room.find_by(name: "みんなの部屋").room_memberships.build
    @room_membership.user = user
    @room_membership.save
  end
end
