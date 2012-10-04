# Capistrano::Relevance

A collection of commonly-used (default) Capistrano recipes for Rails projects at [Relevance](http://thinkrelevance.com).


## Installation

Add these lines to the Gemfile in your Rails application:

```ruby
group :deployment do
  gem 'capistrano', :git => 'git://github.com/capistrano/capistrano', :ref => 'b31e2f5'
  gem 'capistrano-relevance'
end
```

And then execute:

```sh
bundle
```

**Note**: You will notice that we rely on a specific revision of Capistrano in the `Gemfile` above. (Weird, right?)
At the time of this writing, Capistrano 2.13.4 is the latest *released* version;
however, 2.13.4 hardcoded the SCM to `:subversion`, which caused a problem for `capistrano-relevance`.
[Pull request 223](https://github.com/capistrano/capistrano/pull/233) addresses this issue.
`b31e2f5` is the last commit from that pull request, so `capistrano-relevance` needs to depend on that commit until a new version of Capistrano is released (e.g., 2.13.4.1 or 2.13.5).


## Usage

After installing `capistrano-relevance` as described above, you are ready to set up your Capistrano deployment. First, you need to `capify` your app:

    bundle exec capify .

From here, there are two ways that you can use `capistrano-relevance`:

1. Use the [default set of recipes](https://github.com/relevance/capistrano-relevance/blob/master/lib/capistrano/relevance/all.rb), or
2. Use a customized set of recipes.

We'll first walk through the process for using the default set of recipes.
From there, it's easy for you pick and choose a different set of recipes.


### Using the default set of recipes

#### Configuring deploy.rb

To use the `capistrano-relevance` recipes, you will edit your `config/deploy.rb` file to require the `capistrano-relevance` recipes.
You will also define a few additional required settings.

Here is an example file that is ready for use with `capistrano-relevance`:

```ruby
require 'bundler/capistrano'
require 'capistrano/relevance/all'

set :application, "your_app_name"
set :repository,  "git://github.com/username/your_app_name"

role :web, "your_app_name.example.com"
role :app, "your_app_name.example.com"
role :db,  "your_app_name.example.com", :primary => true
```

#### Noteworthy Assumptions

By default, `capistrano-relevance` [expects](https://github.com/relevance/capistrano-relevance/blob/master/lib/capistrano/relevance/common.rb) to deploy as the following user in the following location:

```ruby
set :user, 'deploy'
set(:deploy_to) { "/var/www/apps/#{application}" }
```

If your server uses a different user, or deploys in a different location, you can override these settings. For example:

```ruby
require 'bundler/capistrano'
require 'capistrano/relevance/all'

set :user, 'apptastic'
set(:deploy_to) { "/home/apptastic/apps/#{application}" }

# other settings here ...
```

#### Deploying

Now you're ready to start deploying your app to your server.
You need to create the directory structure that Capistrano expects and place your database configuration on the server.
Best practices (TM) discourage you from checking in any database credentials into your Git repo.
Instead, you can create a `database.yml` file on your target server.

```sh
bundle exec cap deploy:setup

ssh deploy@your_app_name.example.com

# Create the the directory where you will store your shared configuration.
# If you are using a custom :deploy_to value, you should customize this command accordingly.
mkdir /var/www/apps/[YOUR-APP-NAME]/shared/config

# Add production settings for your database
vim /var/www/apps/[YOUR-APP-NAME]/shared/config/database.yml

# We're done messing around on the server; let's get outta here
exit
```

Now it's time to deploy your Rails app to the server.
Since this is the first time you've deployed this app to the server, you'll need to run a special Capistrano command that does slightly more work than a bare deploy.

```sh
bundle exec cap deploy:cold
```

Congratulations! You should be able to visit `your_app_name.example.com` using your favorite browser and see the application up and running.

For subsequent deploys, you can simply run:

```sh
bundle exec cap deploy
```

## Use a customized set of recipes

When you require `capistrano/relevance/all` in your `deploy.rb` file, it includes the [default set of recipes](https://github.com/relevance/capistrano-relevance/blob/master/lib/capistrano/relevance/all.rb).
If you need something other than the default set of recipes, you can include a customized set of recipes for your app.
To do so, edit your `deploy.rb` file, and replace this line ...

```ruby
require 'capistrano/relevance/all'
```

... with the specific set of recipes you want to use in your app.

For example, imagine that you're using Unicorn instead of Passenger. You might want to include all recipes *except* the Passenger recipe.

```ruby
require 'capistrano/relevance/common'
require 'capistrano/relevance/migrate_after_update_code'
require 'capistrano/relevance/symlink_configs'
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
