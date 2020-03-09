require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/favorite"
require "../../services/repo"
require "../../decorators/article"

module Realworld::Actions::Article
  class Favorite < Realworld::Actions::Base
    include Realworld::Services
    
    def call(env)
      user = env.get("auth").as(Realworld::Models::User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Realworld::Models::Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article

      article = Repo.get!(Realworld::Models::Article, article.id, Repo::Query.preload([:favorites, :tags, :user]))
      
      if article.favorites.select {|f| f.user_id == user.id}.size == 0
        fave = Realworld::Models::Favorite.new
        fave.article = article
        fave.user = user

        changeset = Repo.insert(fave)

        article.favorites << changeset.instance
      end

      response = {"article" => Realworld::Decorators::Article.new(article, user)}
      response.to_json
    end
  end
end