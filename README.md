arrive-web
==========

Arrive uses Ruby 2 and Rails 4.

To install with RVM you'll need to install the latest openssl packages.

An earlier version of openssl from homebrew has problems, so you may want to pre-emptively uninstall it:
  
  brew uninstall openssl

Don't worry, rvm will automatically install it when it needs it.

  rvm get stable --autolibs=3
  rvm requirements
  rvm install ruby-2.0.0-p247

This got me further... to an error with Postgres:
/Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg.rb:4:in `require': dlopen(/Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg_ext.bundle, 9): Library not loaded: @executable_path/../lib/libssl.1.0.0.dylib (LoadError)
  Referenced from: /Applications/Postgres.app/Contents/MacOS/lib/libpq.dylib
  Reason: image not found - /Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg_ext.bundle
	from /Users/dcam/.rvm/gems/ruby-2.0.0-p247@arrive/gems/pg-0.15.1/lib/pg.rb:4:in `<top (required)>'