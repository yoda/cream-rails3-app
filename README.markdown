# Cream Rails 3 sample app

Under construction...

## Status: Sept. 19, 2010

Currently the *permits* generator has been to generate default permits. More to follow as I get futher.
This app will be the template for the design of the Cream *config* generator.

## Steps
   
in *Gemfile* insert:

gem 'cream',      '~> 0.5.4'
gem 'mm-devise',  '~> 1.1.2'

Install devise 
run "rails g devise:install"

Add to application.rb
config.action_mailer.default_url_options = { :host => 'localhost:3000' }

root :to => "home#index"

app/views/layouts/application.html.erb

<pre>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>  
</pre>

Create devise user

Note ORM argument optional as it will use the correct ORM if configured correctly in the devise initializer!

config/initializers/devise.rb
  require 'devise/orm/mongo_mapper'

run "rails g devise User --orm ORM"

Configure default permits 
run "rails g permits"