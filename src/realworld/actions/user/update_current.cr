require "../base"
require "../../errors"
require "../../models/user"
require "../../services/repo"
require "crypto/bcrypt/password"

module Realworld::Actions::User
  class UpdateCurrent < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User)

      params = env.params.json["user"].as(Hash)
      
      user.username = params["username"].as(String) if params["username"]?
      user.email = params["email"].as(String) if params["email"]?
      user.image = params["image"].as(String) if params["image"]?
      user.bio = params["bio"].as(String) if params["bio"]?
      
      user.hash = Crypto::Bcrypt::Password.create(params["password"].as(String)).to_s if params["password"]?

      changeset = Repo.update(user)
      if changeset.valid?
        # TODO: Return success
      else
        errors = {} of String => Array(String)
        changeset.errors.reduce(errors) do |memo, error|
          memo[error[:field]] = memo[error[:field]]? || [] of String
          memo[error[:field]] << error[:message]
          memo
        end
        raise Realworld::UnprocessableEntityException.new(env, errors)
      end
    end
  end
end