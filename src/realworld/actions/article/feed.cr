require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/following"
require "../../services/repo"
require "../../decorators/article"

module Realworld::Actions::Article
  class Feed < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User)

      query_limit = env.params.query["limit"]?
      query_offset = env.params.query["offset"]?

      limit = query_limit.to_s.to_i? || 20
      offset = query_limit.to_s.to_i? || 0

      followed_user_ids = user.followed_users.map(&.followed_user_id)

      query = Repo::Query.where(user_id: followed_user_ids).order_by("articles.created_at DESC").limit(limit).offset(offset)
      query = query.preload([:user, :favorites, :tags])
      articles = Repo.all(Article, query)

      response = {"articles" => articles.map { |article| Realworld::Decorators::Article.new(article, user) }}
      response.to_json
    end
  end
end