require "test_helper"
require "json"

describe CouchbaseLiteLocal do

  before do
    @couchbase_lite_local = CouchbaseLiteLocal.start
    @url = @couchbase_lite_local.url
  end

  after do
    @couchbase_lite_local.stop
  end

  it "exposes the url" do
    @couchbase_lite_local.url.wont_be_nil
  end

  it "accepts connections" do
    output = JSON.parse `curl #{@url}/`
    output["CBLite"].must_equal "Welcome"
  end

  it "creates a database" do
    output = JSON.parse `curl -XPUT #{@url}/mydatabase`
    # either the database is already created or we just created it, both good!
    [201, 412].must_include output["status"]
  end
end
