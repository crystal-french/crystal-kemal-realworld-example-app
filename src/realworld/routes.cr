require "kemal"
require "./actions/**"

module Realworld

  post "/api/users" do |env|
    Realworld::Actions::User::Register.new.call(env)
  end

  post "/api/users/login" do |env|
    Realworld::Actions::User::Login.new.call(env)
  end

  get "/api/user" do |env|
    Realworld::Actions::User::CurrentUser.new.call(env)
  end

  put "/api/user" do |env|
    Realworld::Actions::User::UpdateCurrent.new.call(env)
  end



  get "/api/profiles/:username" do |env|
    Realworld::Actions::Profile::Get.new.call(env)
  end

  post "/api/profiles/:username/follow" do |env|
    Realworld::Actions::Profile::Follow.new.call(env)
  end

  delete "/api/profiles/:username/follow" do |env|
    Realworld::Actions::Profile::Unfollow.new.call(env)
  end



  get "/api/articles" do |env|
    Realworld::Actions::Article::List.new.call(env)
  end

  get "/api/articles/feed" do |env|
    Realworld::Actions::Article::Feed.new.call(env)
  end

  get "/api/articles/:slug" do |env|
    Realworld::Actions::Article::Get.new.call(env)
  end

  post "/api/articles" do |env|
    Realworld::Actions::Article::Create.new.call(env)
  end

  put "/api/articles/:slug" do |env|
    Realworld::Actions::Article::Update.new.call(env)
  end

  delete "/api/articles/:slug" do |env|
    Realworld::Actions::Article::Delete.new.call(env)
  end

  post "/api/articles/:slug/favorite" do |env|
    Realworld::Actions::Article::Favorite.new.call(env)
  end

  delete "/api/articles/:slug/favorite" do |env|
    Realworld::Actions::Article::Unfavorite.new.call(env)
  end



  get "/api/articles/:slug/comments" do |env|
    Realworld::Actions::Comment::List.new.call(env)
  end
  
  post "/api/articles/:slug/comments" do |env|
    Realworld::Actions::Comment::Create.new.call(env)
  end

  delete "/api/articles/:slug/comments/:id" do |env|
    Realworld::Actions::Comment::Delete.new.call(env)
  end


  
  get "/api/tags" do |env|
    Realworld::Actions::Tag::List.new.call(env)
  end  
end