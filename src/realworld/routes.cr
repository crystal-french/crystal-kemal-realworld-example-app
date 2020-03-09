require "kemal"
require "./actions/**"

module Realworld

  post "/api/users" do |env|
    Actions::User::Register.new.call(env)
  end

  post "/api/users/login" do |env|
    Actions::User::Login.new.call(env)
  end

  get "/api/user" do |env|
    Actions::User::CurrentUser.new.call(env)
  end

  put "/api/user" do |env|
    Actions::User::UpdateCurrent.new.call(env)
  end



  get "/api/profiles/:username" do |env|
    Actions::Profile::Get.new.call(env)
  end

  post "/api/profiles/:username/follow" do |env|
    Actions::Profile::Follow.new.call(env)
  end

  delete "/api/profiles/:username/follow" do |env|
    Actions::Profile::Unfollow.new.call(env)
  end



  get "/api/articles" do |env|
    Actions::Article::List.new.call(env)
  end

  get "/api/articles/feed" do |env|
    Actions::Article::Feed.new.call(env)
  end

  get "/api/articles/:slug" do |env|
    Actions::Article::Get.new.call(env)
  end

  post "/api/articles" do |env|
    Actions::Article::Create.new.call(env)
  end

  put "/api/articles/:slug" do |env|
    Actions::Article::Update.new.call(env)
  end

  delete "/api/articles/:slug" do |env|
    Actions::Article::Delete.new.call(env)
  end

  post "/api/articles/:slug/favorite" do |env|
    Actions::Article::Favorite.new.call(env)
  end

  delete "/api/articles/:slug/favorite" do |env|
    Actions::Article::Unfavorite.new.call(env)
  end



  get "/api/articles/:slug/comments" do |env|
    Actions::Comment::List.new.call(env)
  end
  
  post "/api/articles/:slug/comments" do |env|
    Actions::Comment::Create.new.call(env)
  end

  delete "/api/articles/:slug/comments/:id" do |env|
    Actions::Comment::Delete.new.call(env)
  end


  
  get "/api/tags" do |env|
    Actions::Tag::List.new.call(env)
  end  

  # Ugly workaround for CORS
  options "/api/*" do |env|
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    env.response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    env.response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, Authorization"
    halt(env, 200)
  end
end