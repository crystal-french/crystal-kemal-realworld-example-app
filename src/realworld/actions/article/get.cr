require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/favorite"
require "../../services/repo"
require "../../decorators/article"

module Realworld::Actions::Article
  class Get < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User?)

      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article

      article = Repo.get!(Article, article.id, Repo::Query.preload([:tags, :favorites, :user]))

      response = {"article" => Realworld::Decorators::Article.new(article, user)}
      response.to_json
    end
  end
end