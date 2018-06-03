require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../services/repo"
require "../../decorators/article"

module Realworld::Actions::Article
  class List < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services
    
    def call(env)
      user = env.get("auth").as(User?)
      
      filter_tag = env.params.query["tag"]?
      filter_author = env.params.query["author"]?
      filter_favorited_by = env.params.query["favorited"]?

      limit = env.params.query["limit"]?.try(&.to_i) || 20
      offset = env.params.query["offset"]?.try(&.to_i) || 0

      query = Repo::Query.order_by("articles.created_at DESC").limit(limit).offset(offset)
      query = query.join(:tags).where("tags.name = ?", filter_tag) if filter_tag
      query = query.join(:user).where("users.username = ?", filter_author) if filter_author
      
      if filter_favorited_by
        user_favorited_by = Repo.get_by(User, username: filter_favorited_by)
        raise Realworld::NotFoundException.new(env) if !user_favorited_by

        query = query.join(:favorites).where("favorites.user_id = ?", user_favorited_by.id)
      end

      query = query.preload([:tags, :user, :favorites])

      articles = Repo.all(Article, query)

      response = {"articles" => articles.map { |article| Realworld::Decorators::Article.new(article, user) }, "articlesCount" => articles.size}
      response.to_json
    end
  end
end