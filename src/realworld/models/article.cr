module Realworld::Models
  class Article < Crecto::Model
    schema :articles do
      field :slug        , String
      field :title       , String
      field :body        , String
      field :description , String
      has_many :tag_usages, TagUsage, dependent: :destroy
      has_many :favorites, Favorite, dependent: :destroy
      has_many :comments, Comment, dependent: :destroy
      has_many :tags, Tag, through: :tag_usages
      belongs_to :user, User
    end

    validate_required [:slug, :title, :body, :description, :user]
  end
end