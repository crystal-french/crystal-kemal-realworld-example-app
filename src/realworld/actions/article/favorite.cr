require "../base"
require "../../errors"
require "../../models/user"
require "../../models/article"
require "../../models/favorite"
require "../../services/repo"

module Realworld::Actions::Article
  class Favorite < Realworld::Actions::Base
    include Realworld::Services
    
    def call(env)
      user = env.get("auth").as(Realworld::Models::User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Realworld::Models::Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article
      
      if article.user_id != user.id
        article.favorites = Repo.get_association(article, :favorites).as(Array(Realworld::Models::Favorite))
        if article.favorites.select {|f| f.user_id == user.id}.size == 0
          fave = Realworld::Models::Favorite.new
          fave.article = article
          fave.user = user

          changeset = Repo.insert(fave)

          article.favorites << changeset.instance
        end

        # TODO: Return success
      else
        raise Realworld::ForbiddenException.new(env)
      end
    end
  end
end