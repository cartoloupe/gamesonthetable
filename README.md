# gamesonthetable
a table on which there are games

## goals
 - [ ] players should log in
 - [ ] they should see other players at the table
 - [ ] they should be able to play some games
 - [ ] the game should involve simultaneous input, not necessarily real-time
 - [ ] the game should update each player's displays via angular's reactive models

## Testing

Currently, we support two kinds of testing: rails testing with minitest and
angular testing with jasmine. Plans are to add protractor for e2e testing.


For minitest, the test suite is located in the test subdirectory. For jasmine, the test suite is located in the spec subdirectory.

To run tests use guard:

`bundle exec guard`

Note, to manually run the jasmine tests, you can use:

`RAILS_ENV=test bundle exec rake spec:javascript`


## setup
1. set up assets: `bundle exec rake bower:install`
1. run the server: `bundle exec rails server`

### DB setup
```bash
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:migrate
```

# resources
## websockets
- [websocket-rails](https://github.com/websocket-rails/websocket-rails)
  - http://webchat.freenode.net/#websocket-rails
  - [moaa/websocket-rails-demo](https://github.com/moaa/websocket-rails-demo)

## authentication with rails and angular
- [angular_devise](https://github.com/cloudspace/angular_devise)

# details
## js
### assets
`bundle exec rake -T bower`
assets are located in the `Bowerfile`
`bundle exec rake bower:install` to install them
- ^ [from this tutorial](http://angular-rails.com/find_and_browse.html)


## rails
### debugging
```ruby
logger.debug
```

```haml
= debug params
```

^ [railsguides](http://guides.rubyonrails.org/debugging_rails_applications.html)

### how to use helper in controller
```ruby
class PlayersController
  include PlayersHelper
```
given `app/helpers/players_helper.rb`:
```ruby
module PlayersHelper
  # logs in the given user
  def log_in(user)
    player[:user_id] = user.id
  end
end
```

### seeds
`db/seeds.rb`

^ [setting up a seeds.rb file](http://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html)

### adding haml
`gem 'haml-rails'`

^ [haml and rails](http://railsapps.github.io/rails-haml.html)

### generating migrations
```ruby
rails g migration add_description_to_products description:string
rails g migration add_product_type_to_products product_type:string
rake db:migrate
```

^ [stackoverflow](http://stackoverflow.com/questions/15162055/rails-generate-migration#answer-20008381)

## deploying
`bundle exec mina setup`
`bundle exec mina deploy`
### forcing asset precompilation
`bundle exec mina deploy force_assets=1`
^ [from the mina site](http://nadarei.co/mina/tasks/rails_assets_precompile.html)
