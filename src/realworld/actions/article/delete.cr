require "../base"
require "../../models/user"
require "../../models/article"
require "../../services/repo"

module Realworld::Actions::Article
  class Delete < Realworld::Actions::Base
    include Realworld::Models
    include Realworld::Services

    def call(env)
      user = env.get("auth").as(User)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      if article && article.user_id == user.id
        article.tags = Repo.get_association(article, :tags).as(Array(Tag))
        changeset = Repo.delete(article)
        if changeset.valid?
          # Return nothing :D
        else
          # TODO: Return error
        end
      else
        # TODO: Return error
      end
    end
  end
end