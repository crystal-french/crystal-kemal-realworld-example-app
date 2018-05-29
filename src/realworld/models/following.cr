require "crecto"
require "mysql"

require "./user"

module Realworld::Models
  class Following < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil
  
    schema :following, primary_key: false do
      belongs_to :follower_user, User, foreign_key: :follower_user_id
      belongs_to :followed_user, User, foreign_key: :followed_user_id
    end
  end
end