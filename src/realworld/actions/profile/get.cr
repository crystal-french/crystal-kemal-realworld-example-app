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
      
      p_owner = Repo.get_by(User, username: env.params.url["username"])
      raise Realworld::NotFoundException.new(env) if !p_owner

      response = {"profile" => Realworld::Decorators::Profile.new(p_owner, user)}
      response.to_json
    end
  end
end