require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/favorite"
require "../../services/repo"

module Realworld::Actions::Article
  class Unfavorite < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article
      raise Realworld::ForbiddenException.new(env) if article.user_id == user.id

      query = Repo::Query.where(article_id: article.id, user_id: user.id)
      changeset = Repo.delete_all(Favorite, query)

      article.favorites = Repo.get_association(article, :favorites).as(Array(Realworld::Models::Favorite))

      # TODO: Return success
    end
  end
end