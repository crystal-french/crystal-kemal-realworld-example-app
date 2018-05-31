require "../base"
require "../../services/repo"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class UpdateCurrent < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User)
      parsed = parse_json_body(env.request.body)
      if values = parsed["user"]?
        user.hash = Crypto::Bcrypt::Password.create(values["password"].as_s).to_s if values["password"]?
        user.username = values["username"].as_s if values["username"]?
        user.email = values["email"].as_s if values["email"]?
        user.image = values["image"].as_s if values["image"]?
        user.bio = values["bio"].as_s if values["bio"]?

        changeset = Repo.update(user)
        if changeset.valid?
          # TODO: Return success
        else
          # TODO: Return error
        end
      else
        # TODO: Return error
      end
    end
  end
end