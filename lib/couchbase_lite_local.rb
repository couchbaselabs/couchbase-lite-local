# load couchbase lite
require 'java'

root = "#{File.dirname(__FILE__)}/.."

Dir["#{root}/vendor/*.jar"].each { |jar|
  $CLASSPATH << jar
  require jar
}

# load native jars for platform
if RbConfig::CONFIG["target_cpu"] =~ /x86/ && RbConfig::CONFIG["host_os"] =~ /darwin/
  require "#{root}/vendor/macosx/couchbase-lite-java-native.jar"
elsif RbConfig::CONFIG["target_cpu"] =~ /x86_64/ && RbConfig::CONFIG["host_os"] =~ /linux/
  require "#{root}/vendor/linux_x86_64/couchbase-lite-java-native.jar"
elsif RbConfig::CONFIG["target_cpu"] =~ /arm/
  require "#{root}/vendor/linux_arm/couchbase-lite-java-native.jar"
else
  puts <<-EOF
  Currently there is no compiled version for your platform.
  Sorry about that.

  Feel free to add a request at https://github.com/couchbaselabs/couchbase-lite-local"
  EOF
  exit 1
end

java_import com.couchbase.lite.listener.LiteListener
java_import com.couchbase.lite.listener.LiteServlet
java_import com.couchbase.lite.listener.Credentials
java_import com.couchbase.lite.router.URLStreamHandlerFactory
java_import com.couchbase.lite.View
java_import com.couchbase.lite.javascript.JavaScriptViewCompiler
java_import com.couchbase.lite.Manager
java_import com.couchbase.lite.JavaContext
java_import com.couchbase.lite.util.Log


module CouchbaseLiteLocal
  DEFAULT_PORT = 5984
  def self.start port = DEFAULT_PORT
    HTTPListener.new port
  end

  class HTTPListener

    def initialize port
      @credentials = Credentials.new
      URLStreamHandlerFactory.registerSelfIgnoreError
      View.setCompiler JavaScriptViewCompiler.new
      server = start_cblite
      @port = start_cblite_listener(port, server, @credentials)
    end

    def stop
      @thread.kill if @thread
    end

    def url
      "http://#{login}:#{password}@localhost:#{@port}"
    end

    def login
      @credentials.getLogin
    end

    def password
      @credentials.getPassword
    end

    private
    def start_cblite
      begin
        # get the actual database
        Manager.new JavaContext.new, Manager::DEFAULT_OPTIONS
      rescue IOException => e
        raise "Failed to open databse #{e}"
      end
    end

    def start_cblite_listener port, server, credentials
      listener = LiteListener.new server, port, credentials
      @thread = Thread.new { listener.run }

      # return the actual port where the listener runs on, this might differ from
      # the port passed if it is in use.
      listener.getListenPort
    end

  end
end
