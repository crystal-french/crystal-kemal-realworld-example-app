require "crecto"
require "mysql"

require "./tag"
require "./user"
require "./comment"
require "./favorite"

module Realworld::Models
  class Article < Crecto::Model
    schema :articles do
      field :slug        , String
      field :title       , String
      field :body        , String
      field :description , String
      has_many :favorites, Favorite, dependent: :destroy
      has_many :comments, Comment, dependent: :destroy
      has_many :tags, Tag, dependent: :destroy
      belongs_to :user, User
    end

    validate_required [:slug, :title, :body, :description, :user]
  end
end