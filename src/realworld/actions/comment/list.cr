require "../base"
require "../../errors"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class List < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User?)
      
      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article

      query = Repo::Query.where(article_id: article.id)
      comments = Repo.all(Comment, query)

      # TODO: return success
    end
  end
end