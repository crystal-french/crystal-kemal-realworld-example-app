require "../base"
require "../../errors"
require "../../models/user"
require "../../models/following"
require "../../services/repo"
require "../../decorators/profile"

module Realworld::Actions::Profile
  class Follow < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User)

      profile_owner = Repo.get_by(User, username: env.params.url["username"])
      raise Realworld::NotFoundException.new(env) if !profile_owner

      if user.followed_users.select {|fu| fu.followed_user_id == profile_owner.id}.size == 0
        following = Following.new
        following.follower_user_id = user.id
        following.followed_user_id = profile_owner.id

        Repo.insert(following)

        user.followed_users << following
      end

      response = {"profile" => Realworld::Decorators::Profile.new(profile_owner, user)}
      response.to_json
    end
  end
end