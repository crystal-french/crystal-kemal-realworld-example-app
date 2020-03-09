require "json"
require "../models/user"

module Realworld::Decorators
  class Profile
    def initialize(@owner : Realworld::Models::User, @viewer : Realworld::Models::User?)
    end

    def to_json(builder : JSON::Builder)
      following = false

      if auth_user = @viewer
        following = auth_user.followed_users.select {|fu| fu.followed_user_id == @owner.id }.size > 0
      end

      builder.object do
        builder.field("username", @owner.username)
        builder.field("bio", @owner.bio)
        builder.field("image", @owner.image)
        builder.field("following", following)
      end
      
    end
  end
end