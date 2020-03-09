require "../base"
require "../../errors"
require "../../models/user"
require "../../services/repo"
require "../../decorators/profile"

module Realworld::Actions::Profile
  class Get < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User?)
      
      profile_owner = Repo.get_by(User, username: env.params.url["username"])
      raise Realworld::NotFoundException.new(env) if !profile_owner

      response = {"profile" => Realworld::Decorators::Profile.new(profile_owner, user)}
      response.to_json
    end
  end
end