require "crecto"
require "mysql"

require "./article"

module Realworld::Models
  class Tag < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema :tags do
      field :name, String
      belongs_to :article, Article
    end

    validate_required [:name, :article]
  end
end