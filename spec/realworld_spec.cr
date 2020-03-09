require "./spec_helper"

describe Realworld do

  it "Returns correct message on HTTP 401 error" do
    get "/api/articles/feed"

    expected = {"status" => 401, "error" => "Unauthorized"}.to_json
    response.body.should eq(expected)
  end
  
end
