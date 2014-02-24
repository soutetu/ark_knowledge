Knowledge
=========

[![Build Status](https://travis-ci.org/i2bskn/knowledge.png?branch=master)](https://travis-ci.org/i2bskn/knowledge)
[![Coverage Status](https://coveralls.io/repos/i2bskn/knowledge/badge.png)](https://coveralls.io/r/i2bskn/knowledge)
[![Code Climate](https://codeclimate.com/github/i2bskn/knowledge.png)](https://codeclimate.com/github/i2bskn/knowledge)
[![Dependency Status](https://gemnasium.com/i2bskn/knowledge.png)](https://gemnasium.com/i2bskn/knowledge)

Knowledge sharing of limited extent.

## Ruby version

* Ruby 2.0.0
* MySQL

## Configuration

#### Sessions secret key

```
export RAILS_SECRET_KEY=rails_secret_key_base
```

#### Database

```
export RAILS_DB_USER=user_name
export RAILS_DB_PASSWORD=password
export RAILS_DB_HOST=localhost
export RAILS_DB_PORT=3306
```

#### Mail

Edit `config/application.rb` when not using the gmail.

```
export RAILS_MAIL_ADDRESS=foo@gmail.com
export RAILS_MAIL_PASSWORD=secret
```

#### Others

Copy and editing of the configuration file.

```
cp -pi config/initializers/hosting.rb{.example,}
vi config/initializers/hosting.rb
```

## Setup

Please complete the above setting before running the setup procedure.  

#### Install gems

```
bundle install --path vendor/bundle
```

#### Create database and tables

Don't forget the RAILS_ENV when deploying.

```
bundle exec rake db:create
bundle exec rake db:migrate
```

#### Create directory and user

Create a location in which to save the file.

```
bundle exec rake files:create_directory
```

Create a super user.  
Please delete or change later e-mail address of the super user.  
Run `bundle exec rake super_user:destroy` If you want to delete of super user.

```
bundle exec rake super_user:create
```
