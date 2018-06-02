require "json"
require "../models/user"
require "../services/auth"

module Realworld::Decorators
  class User
    def initialize(@user : Realworld::Models::User)
    end

    def to_json(builder : JSON::Builder)

      builder.object do
        builder.field("email", @user.email)
        builder.field("token", Realworld::Services::Auth.jwt_for(@user))
        builder.field("username", @user.username)
        builder.field("bio", @user.bio)
        builder.field("image", @user.image)
      end

    end
  end
end