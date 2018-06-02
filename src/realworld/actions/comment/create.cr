require "../base"
require "../../errors"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"
require "../../decorators/comment"
require "../../decorators/errors"

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
        response = {"comment" => Realworld::Decorators::Comment.new(changeset.instance, user)}
        response.to_json
      else
        errors = {"errors" => Realworld::Decorators::Errors.new(changeset.errors)}
        raise Realworld::UnprocessableEntityException.new(env, errors.to_json)
      end
    end
  end
end