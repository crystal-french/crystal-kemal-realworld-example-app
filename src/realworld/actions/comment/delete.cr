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
          errors = {"errors" => map_changeset_errors(changeset.errors)}
          raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
        end
      else
        raise Realworld::ForbiddenException.new(env)
      end
    end
  end
end