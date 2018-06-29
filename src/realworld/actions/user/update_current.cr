require "../base"
require "../../errors"
require "../../models/user"
require "../../services/repo"
require "../../decorators/user"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class UpdateCurrent < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User)

      params = env.params.json["user"].as(Hash)
      
      user.username = params["username"].as_s if params["username"]?
      user.email = params["email"].as_s if params["email"]?
      user.image = params["image"].as_s? if params["image"]?
      user.bio = params["bio"].as_s? if params["bio"]?
      
      user.hash = Crypto::Bcrypt::Password.create(params["password"].as_s).to_s if params["password"]?

      changeset = Repo.update(user)
      if changeset.valid?
        response = {"user" => Realworld::Decorators::User.new(changeset.instance)}
        response.to_json
      else
        errors = {"errors" => map_changeset_errors(changeset.errors)}
        raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
      end
    end
  end
end