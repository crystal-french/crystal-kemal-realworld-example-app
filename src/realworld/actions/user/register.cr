require "../base"
require "../../models/user"
require "../../services/repo"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class Register < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      parsed = parse_json_body(env.request.body)
      if values = parsed["user"]?
        
        user = User.new
        user.username = values["username"].as_s if values["username"]?
        user.email = values["email"].as_s if values["email"]?
        user.hash = Crypto::Bcrypt::Password.create(values["password"].as_s).to_s if values["password"]?

        changeset = Repo.insert(user)
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