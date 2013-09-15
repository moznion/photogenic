# photogenic [![Build Status](https://travis-ci.org/moznion/photogenic.png?branch=master)](https://travis-ci.org/moznion/photogenic)
blah, blah

# Getting started (For developer)

1. Install dependencies

        $ bundle install --path=.bundle/gems

2. Migrate DB

        $ bundle exec rake db:migrate
        $ bundle exec rake db:migrate RAILS_ENV='development'

3. Up the application server

        $ bundle exec rails s
