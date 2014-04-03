Arrive Mobile Server
====================

This is the mobile server for the Arrive platform. It provides administrative access for users as well as an API for the client mobile app.

Tech Stack
----------

This server app is built using Rails 4.0 and Ruby 2.0. We use RSpec for unit testing.

Dev Machine Setup
-----------------

1. Install ruby version 2.0

2. Install Postgres. There are two options for this:

  * Homebrew Install.

          brew install postgresql
          initdb /usr/local/var/postgres -E utf8

          To start database:
          pg_ctl -D /usr/local/var/postgres -l logfile start

  * Standalone Homebrew install. This is the easiest option. Google for Postgres app, download, use.

3. Install dependencies

    >cd arrive-server && bundle install

4. Create your database config file.

    >cp config/database.yml.sample config/database.yml

5. Setup the database.

    >rake db:setup
            
6. Start the server. (Make sure your postgres DB is running).

    >rails server

7. Open a browser and hit localhost:3000

Troubleshooting
---------------

* To install with RVM you'll need to install the latest openssl packages.

* An earlier version of openssl from homebrew has problems, so you may want to pre-emptively uninstall it:

    >brew uninstall openssl

* Don't worry, rvm will automatically install it when it needs it.

    >rvm get stable --autolibs=3
    rvm requirements
    rvm install ruby-2.0.0-p247

* This got me further... to an error with Postgres:

    >/Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg.rb:4:in `require':
    dlopen(/Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg_ext.bundle, 9): Library not loaded:
    @executable_path/../lib/libssl.1.0.0.dylib (LoadError)
    Referenced from: /Applications/Postgres.app/Contents/MacOS/lib/libpq.dylib
    Reason: image not found - /Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg_ext.bundle
    from /Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg.rb:4:in `<top (required)>'

* This helped me with standalone postgress server
  
    >Here's the error message: connections on Unix domain socket "/var/pgsql_socket/.s.PGSQL.5432"?
    >Here's a link that tells you how to solve it: http://jaygoldman.com/2012/11/fixing-postgres-connection-errors-on-mountain-lion/
