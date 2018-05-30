require "../base"
require "../../models/article"
require "../../models/comment"
require "../../services/repo"

module Realworld::Actions::Comment
  class Create < Realworld::Actions::Base
    def call(env, user)
      if user
        article = Realworld::Services::Repo.get_by(Realworld::Models::Article, slug: env.params.url["slug"])
        if article
          parsed = parse_json_body(env.request.body)
          if values = parsed["comment"]?
            comment = Realworld::Models::Comment.new
            comment.body = values["body"].as_s if values["body"]
            comment.user = user
            comment.article = article

            changeset = Realworld::Services::Repo.insert(comment)
            if changeset.valid?
              # TODO: return success
            else
              # TODO: return error
            end
          else
            # TODO: return error
          end
        else
          # TODO: return error
        end  
      else
        # TODO: return error
      end
    end
  end
end