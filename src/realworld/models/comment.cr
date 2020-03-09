require "crecto"
require "mysql"

require "./user"
require "./article"

module Realworld::Models
  class Comment < Crecto::Model
    schema :comments do
      field :body, String
      belongs_to :user, User
      belongs_to :article, Article
    end

    validate_required [:body, :user_id, :article_id]
  end
end