require "../base"
require "../../models/user"
require "../../services/repo"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class Login < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      parsed = parse_json_body(env.request.body)
      if values = parsed["user"]?

        email = values["email"]? ? values["email"].as_s : ""
        password = values["password"]? ? values["password"].as_s : ""

        user = Repo.get_by(User, email: email)
        if user && Crypto::Bcrypt::Password.new(user.hash.not_nil!) == password
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