# Couchbase Lite Local
Run a local instance of couchbase lite on you Macbook or Raspberry Pi and have
it accessible via HTTP.

## What?
Couchbase Lite is a mobile database solutin to provide a NoSQL database for
small devices. This little tool runs it locally and exposes it's HTTP interface
so you can interact with it from anything on your local machine (or even the
outside). Couchbase Lite also provides syncinc capabilities so you can sync your
local database to a remote using Couchbase Server. 

Take a look at [the REST
API](http://developer.couchbase.com/mobile/develop/references/couchbase-lite/rest-api/index.html)
for everything you can do.

## How?
This little jRuby tool is heavily inspired by
[Couchbase-Lite-PhoneGap-Plugin](https://github.com/couchbaselabs/Couchbase-Lite-PhoneGap-Plugin)
which does the same thing on android and iOS, but it runs locally on your Mac
(or Pi)

## Install and use

clone the git repository and install the dependencies

```
$ git clone https://github.com/couchbaselabs/couchbase-lite-local
$ bundle install
```

and run the contained script

```
$ bin/cbl-local
```

make sure you are using [JRuby](http://jruby.org/)

