require "../base"
require "../../models/user"
require "../../models/article"
require "../../services/repo"

module Realworld::Actions::Article
  class Favorite < Realworld::Actions::Base
    include Realworld::Services
    
    def call(env)
      user = env.get("auth").as(Realworld::Models::User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Realworld::Models::Article, slug: slug)
      if article && article.user_id != user.id
        fave = Realworld::Models::Favorite.new
        fave.article = article
        fave.user = user

        changeset = Repo.insert(fave)
        if changeset.valid?
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