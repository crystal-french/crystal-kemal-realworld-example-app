require "../base"
require "../../errors"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class Create < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env)
      user = env.get("auth").as(User)

      slug = env.params.url["slug"]

      article = Repo.get_by(Article, slug: slug)
      raise Realworld::NotFoundException.new(env) if !article

      comment = Comment.new
      comment.body = env.params.json["comment"].as(Hash)["body"].as(String)
      comment.user = user
      comment.article = article

      changeset = Repo.insert(comment)
      if changeset.valid?
        # TODO: return success
      else
        errors = {} of String => Array(String)
        changeset.errors.reduce(errors) do |memo, error|
          memo[error[:field]] = memo[error[:field]]? || [] of String
          memo[error[:field]] << error[:message]
          memo
        end
        raise Realworld::UnprocessableEntityException.new(env, errors)
      end
    end
  end
end