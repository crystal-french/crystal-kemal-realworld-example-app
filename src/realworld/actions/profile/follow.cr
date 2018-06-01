require "../base"
require "../../errors"
require "../../models/user"
require "../../models/following"
require "../../services/repo"

module Realworld::Actions::Profile
  class Follow < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User)

      p_owner = Repo.get_by(User, username: env.params.url["username"])
      raise Realworld::NotFoundException.new(env) if !p_owner

      if user.followed_users.select {|fu| fu.followed_user_id == p_owner.id}.size == 0
        following = Following.new
        following.follower_user_id = user.id
        following.followed_user_id = p_owner.id

        Repo.insert(following)

        user.followed_users << following
      end

      # TODO: Return success
    end
  end
end