require "kemal"
require "./services/*"
require "./actions/**"

module Realworld
  before_all do |env|
    env.response.content_type = "application/json"
  end


  post "/api/users" do |env|
    Realworld::Actions::User::Register.new.call(env)
  end

  post "/api/users/login" do |env|
    Realworld::Actions::User::Login.new.call(env)
  end

  get "/api/user" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::User::CurrentUser.new.call(env, user)
  end

  put "/api/user" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::User::UpdateCurrent.new.call(env, user)
  end



  get "/api/profiles/:username" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Profile::Get.new.call(env, user)
  end

  post "/api/profiles/:username/follow" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Profile::Follow.new.call(env, user)
  end

  delete "/api/profiles/:username/follow" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Profile::Unfollow.new.call(env, user)
  end



  get "/api/articles" do |env|
    Realworld::Actions::Article::List.new.call(env)
  end

  get "/api/articles/feed" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Article::Feed.new.call(env, user)
  end

  get "/api/articles/:slug" do |env|
    Realworld::Actions::Article::Get.new.call(env)
  end

  post "/api/articles" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Article::Create.new.call(env, user)
  end

  put "/api/articles" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Article::Update.new.call(env, user)
  end

  delete "/api/articles/:slug" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Article::Delete.new.call(env, user)
  end

  post "/api/articles/:slug/favorite" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Article::Favorite.new.call(env, user)
  end

  delete "/api/articles/:slug/favorite" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Article::Unfavorite.new.call(env, user)
  end



  get "/api/articles/:slug/comments" do |env|
    Realworld::Actions::Comment::List.new.call(env)
  end
  
  post "/api/articles/:slug/comments" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Comment::Create.new.call(env, user)
  end

  delete "/api/articles/:slug/comments/:id" do |env|
    user = Realworld::Services::Auth.auth(env.headers["Authorization"]?)
    Realworld::Actions::Comment::Delete.new.call(env, user)
  end


  
  get "/api/tags" do |env|
    Realworld::Actions::Tag::List.new.call(env)
  end  
end