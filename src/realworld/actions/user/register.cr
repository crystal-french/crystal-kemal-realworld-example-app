require "../base"
require "../../errors"
require "../../models/user"
require "../../services/repo"
require "../../decorators/errors"
require "../../decorators/user"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class Register < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      params = env.params.json["user"].as(Hash)

      email = params["email"].as_s
      username = params["username"].as_s
      password = params["password"].as_s

      user = User.new
      user.email = email
      user.username = username
      user.hash = Crypto::Bcrypt::Password.create(password).to_s

      changeset = Repo.insert(user)
      if changeset.valid?
        response = {"user" => Realworld::Decorators::User.new(changeset.instance)}
        response.to_json
      else
        errors = {"errors" => Realworld::Decorators::Errors.new(changeset.errors)}
        raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
      end
    end

  end
end