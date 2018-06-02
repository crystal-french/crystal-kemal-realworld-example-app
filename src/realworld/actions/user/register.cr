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
      email = env.params.json["user"].as(Hash)["email"].as(String)
      username = env.params.json["user"].as(Hash)["username"].as(String)
      password = env.params.json["user"].as(Hash)["password"].as(String)

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