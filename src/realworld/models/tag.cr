module Realworld::Models
  class Tag < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema :tags do
      field :name, String
      has_many :usages, TagUsage
      has_many :articles, Article, through: :usages
    end

    validate_required [:name]
    unique_constraint :name
  end
end