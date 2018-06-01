require "../base"
require "../../models/user"
require "../../services/repo"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class Login < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      email = env.params.json["user"].as(Hash)["email"].as(String)
      password = env.params.json["user"].as(Hash)["password"].as(String)

      user = Repo.get_by(User, email: email)
      if user && Crypto::Bcrypt::Password.new(user.hash.not_nil!) == password
        # TODO: Return success
      else
        # TODO: Return error
      end
    end

  end
end