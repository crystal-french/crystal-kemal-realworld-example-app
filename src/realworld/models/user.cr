module Realworld::Models
  class User < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema :users do
      field :username , String
      field :hash     , String
      field :email    , String
      field :bio      , String
      field :image    , String
      has_many :articles, Article, dependent: :destroy
      has_many :comments, Comment, dependent: :destroy
      has_many :follower_users, Following, foreign_key: :followed_user_id
      has_many :followed_users, Following, foreign_key: :follower_user_id
      has_many :favorites, Favorite, dependent: :destroy
    end

    validate_required [:username, :hash, :email]
    validate_format :email, /^[^@]+@(\w+\.)+\w+$/
    unique_constraint :username
    unique_constraint :email
  end
end