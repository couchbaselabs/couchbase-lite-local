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
    refute @couchbase_lite_local.url.nil?
  end

  it "accepts connections" do
    output = JSON.parse `curl #{@url}/`
    assert_equal output["CBLite"], "Welcome"
  end

  it "creates a database" do
    output = JSON.parse `curl -XPUT #{@url}/mydatabase`
    # either the database is already created or we just created it, both good!
    assert_includes [201, 412], output["status"]
  end

  it "uses the passed credentials" do
    my_lite_local = CouchbaseLiteLocal.start 11011, "foo", "bar"
    assert my_lite_local.url.start_with?("http://foo:bar@")
    my_lite_local.stop
  end
end
