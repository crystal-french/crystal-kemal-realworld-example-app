require "../base"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class List < Realworld::Actions::Base
    def call(env)
      article = Realworld::Services::Repo.get_by(Realworld::Models::Article, slug: env.params.url["slug"])
      if article
        query = Realworld::Services::Repo::Query.where(article_id: article.id)
        comments = Realworld::Services::Repo.all(Realworld::Models::Comment, query)

        # TODO: return success
      else
        # TODO: return error
      end
    end
  end
end