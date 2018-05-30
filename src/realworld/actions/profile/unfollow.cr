require "../base"
require "../../models/user"
require "../../models/following"
require "../../services/repo"

module Realworld::Actions::Profile
  class Unfollow < Realworld::Actions::Base
    def call(env, user)
      if user
        p_owner = Realworld::Services::Repo.get_by!(Realworld::Models::User, username: env.params.url["username"])
        if p_owner
          if following = user.followed_users.select {|fu| fu.followed_user_id == p_owner.id}.first?
            query = Realworld::Services::Repo::Query.where(follower_user_id: user.id, followed_user_id: p_owner.id)
            changeset = Realworld::Services::Repo.delete_all(Realworld::Models::Following, query)
            
            user.followed_users.delete(following)
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