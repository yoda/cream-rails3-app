# Cream Rails 3 sample app

Currently under construction... the gem combinations used in this app have recently been updated (locally) and not all been released.

## Status: Sept. 24, 2010

This app will be the template for the design of the Cream *config* generator. The following steps have/should be done.

## Steps

## Configure gemfile
   
in *Gemfile* insert:

<pre>
  gem 'cream',        '~> 0.5.5' 
  gem 'devise',       '~> 1.2.0' 

  # use mongo mapper version of devise
  gem 'mm-devise',    '~> 1.1.3'

  # use mongo mapper version of roles
  gem 'roles_mongo_mapper',    '~> 0.1.2'
  
</pre>

### Install devise 

<code>rails g devise:install</code>

Add to application.rb             
<code>config.action_mailer.default_url_options = { :host => 'localhost:3000' }</code>

If no :home controller, create one with an :index view.

<code>root :to => "home#index"</code>

In app/views/layouts/application.html.erb

Insert after opening :body element
<pre>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>  
</pre>

### Create devise user

Note ORM argument optional as it will use the correct ORM if configured correctly in the devise initializer!

Inside config/initializers/devise.rb, change to:
<code>require 'devise/orm/mongo_mapper'</code>  

Create devise User for Mongo Mapper
<code>rails g mongo_mapper:devise User</code>

## Permits

Configure default permits 

<code>rails g permits</code>

## Configure and generate roles

<code>rails g mongo_mapper:roles</code>