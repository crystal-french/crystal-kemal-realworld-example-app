require "../base"
require "../../errors"
require "../../models/user"
require "../../models/following"
require "../../services/repo"
require "../../decorators/profile"

module Realworld::Actions::Profile
  class Unfollow < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(Realworld::Models::User)
      
      profile_owner = Repo.get_by(User, username: env.params.url["username"])
      raise Realworld::NotFoundException.new(env) if !profile_owner
      
      if following = user.followed_users.select {|fu| fu.followed_user_id == profile_owner.id}.first?
        query = Repo::Query.where(follower_user_id: user.id, followed_user_id: profile_owner.id)
        changeset = Repo.delete_all(Following, query)
        
        user.followed_users.delete(following)
      end

      response = {"profile" => Realworld::Decorators::Profile.new(profile_owner, user)}
      response.to_json
    end
  end
end