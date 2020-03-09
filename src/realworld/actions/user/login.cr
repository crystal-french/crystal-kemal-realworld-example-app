require "../base"
require "../../errors"
require "../../models/user"
require "../../services/repo"
require "../../decorators/user"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class Login < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      params = env.params.json["user"].as(Hash) 

      email = params["email"].as_s
      password = params["password"].as_s

      user = Repo.get_by(User, email: email)
      if user && Crypto::Bcrypt::Password.new(user.hash.not_nil!).verify(password)
        response = {"user" => Realworld::Decorators::User.new(user)}
        response.to_json
      else
        errors = {"errors" => {"body" => ["Invalid username or password"]}}
        raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
      end
    end

  end
end