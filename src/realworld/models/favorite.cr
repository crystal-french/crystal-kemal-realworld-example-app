require "crecto"
require "mysql"

require "./user"
require "./article"

module Realworld::Models
  class Favorite < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil
  
    schema :favorites, primary_key: false do
      belongs_to :user, User
      belongs_to :article, Article
    end

    validate_required [:user_id, :article_id]
  end
end