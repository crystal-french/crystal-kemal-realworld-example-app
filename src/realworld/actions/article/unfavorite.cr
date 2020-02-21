require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/favorite"
require "../../services/repo"
require "../../decorators/article"

module Realworld::Actions::Article
  class Unfavorite < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article

      query = Repo::Query.where(article_id: article.id, user_id: user.id)
      changeset = Repo.delete_all(Favorite, query)

      article = Repo.get!(Article, article.id, Repo::Query.preload([:tags, :favorites, :user]))

      response = {"article" => Realworld::Decorators::Article.new(article, user)}
      response.to_json
    end
  end
end