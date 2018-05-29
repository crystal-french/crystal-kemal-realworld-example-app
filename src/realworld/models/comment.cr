require "crecto"
require "mysql"

require "./user"
require "./article"

module Realworld::Models
  class Comment < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema :comments do
      field :body, String
      belongs_to :user, User
      belongs_to :article, Article
    end

    validate_required [:body, :user, :article]
  end
end