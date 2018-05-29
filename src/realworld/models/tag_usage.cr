module Realworld::Models
  class TagUsage < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema :tag_usages, primary_key: false do
      belongs_to :tag, Tag
      belongs_to :article, Article        
    end
  end
end