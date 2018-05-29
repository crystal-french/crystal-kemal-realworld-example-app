require "../base"
require "../../models/user"
require "../../services/repo"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class Register < Realworld::Actions::Base
    
    def call(env)
      parsed = parse_json_body(env.request.body)
      if values = parsed["user"]?
        
        user = Realworld::Models::User.new
        user.username = values["username"].as_s if values["username"]?
        user.email = values["email"].as_s if values["email"]?
        user.hash = Crypto::Bcrypt::Password.create(values["password"].as_s).to_s if values["password"]?

        changeset = Realworld::Services::Repo.insert(user)
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