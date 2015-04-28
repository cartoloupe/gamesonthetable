# gamesonthetable
a table on which there are games

## goals
 - [ ] players should log in
 - [ ] they should see other players at the table
 - [ ] they should be able to play some games
 - [ ] the game should involve simultaneous input, not necessarily real-time
 - [ ] the game should update each player's displays via angular's reactive models


## websockets
- [websocket-rails](https://github.com/websocket-rails/websocket-rails)
    - http://webchat.freenode.net/#websocket-rails

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
class SessionsController
  include SessionsHelper
```
given `app/helpers/sessions_helper.rb`:
```ruby
module SessionsHelper
  # logs in the given user
  def log_in(user)
    session[:user_id] = user.id
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
