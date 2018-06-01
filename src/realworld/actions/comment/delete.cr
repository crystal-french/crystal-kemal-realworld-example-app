require "../base"
require "../../errors"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class Delete < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models
    
    def call(env)
      user = env.get("auth").as(User)

      slug = env.params.url["slug"]
      id   = env.params.url["id"].to_i64?
      
      raise Realworld::NotFoundException.new(env) if !id
      
      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article
      
      comment = Repo.get(Comment, id)
      raise Realworld::NotFoundException.new(env) if !comment

      if article.id == comment.article_id && user.id == comment.user_id
        changeset = Repo.delete(comment)
        if !changeset.valid?
          errors = {} of String => Array(String)
          changeset.errors.reduce(errors) do |memo, error|
            memo[error[:field]] = memo[error[:field]]? || [] of String
            memo[error[:field]] << error[:message]
            memo
          end
          raise Realworld::UnprocessableEntityException.new(env, errors)
        end
      else
        raise Realworld::ForbiddenException.new(env)
      end
    end
  end
end