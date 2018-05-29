require "../base"
require "../../models/user"
require "../../models/following"
require "../../services/repo"

module Realworld::Actions::Profile
  class Follow < Realworld::Actions::Base
    def call(env, user)
      if user
        p_owner = Realworld::Services::Repo.get_by(Realworld::Models::User, username: env.params.url["username"])
        if p_owner
          if user.followed_users.select {|fu| fu.followed_user_id == p_owner.id}.size = 0
            following = Realworld::Models::Following.new
            following.follower_user_id = user.id
            following.followed_user_id = p_owner.id

            Realworld::Services::Repo.insert(following)

            user.followed_users << following
          end

          # TODO: Return success
        else
          # TODO: Return error
        end
      else
        # TODO: Return error
      end
    end
  end
end