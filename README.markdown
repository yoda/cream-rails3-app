# Cream Rails 3 sample app

Currently under construction... the gem combinations used in this app have recently been updated (locally) and not all been released.

## Status: Sept. 24, 2010

This app will be the template for the design of the Cream *config* generator. The following steps have/should be done.

## Steps 

These are the steps to be taken to get a Cream enabled app up and running with Mongo Mapper. 
I hope my coming generator will minimize the amount of manual steps a great deal! 

*You are most welcome to join in the effort ;)*

## Setup Rails 3 for Mongo DB

Either: Create new app

<code>rails my_app --skip-activerecord</code>

Or in existing app, edit 'config/application.rb'
<pre>
  # require 'rails/all'  

  require "action_controller/railtie"
  require "action_mailer/railtie"
  require "active_resource/railtie"
  require "rails/test_unit/railtie"  
</pre>

## Configure gemfile
   
in *Gemfile* insert:

<pre>
  gem 'cream',        '~> 0.5.5' 
  gem 'devise',       '~> 1.2.0' 

  # use mongo mapper version of devise
  gem 'mm-devise',    '~> 1.1.3'

  # gem "mongo_mapper"

  # use mongo mapper version of roles
  gem 'roles_mongo_mapper',    '~> 0.1.2'
  
</pre>

### Install devise 

<code>rails g devise:install</code>

Add to application.rb             
<code>config.action_mailer.default_url_options = { :host => 'localhost:3000' }</code>

If no Welcome controller, create one with an 'index' view.
<pre>
  get :to => "welcome#index"
  root :to => "welcome#index"  
</pre>

Generate Welcome controller with index action and index view

<code>rails g controller Welcome index</code>

In 'app/views/layouts/application.html.erb'

Insert after opening :body element
<pre>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>  
</pre>

Create Devise views for customizing Session forms and such (optional):

<code>rails g devise:views</code>

Edit any of the view files (optional)

### Create devise user

Note ORM argument optional as it will use the correct ORM if configured correctly in the devise initializer!

Inside 'config/initializers/devise.rb' change to:
<code>require 'devise/orm/mongo_mapper'</code>  

Create devise User for Mongo Mapper
<code>rails g mongo_mapper:devise User</code>

## Permits

Configure default permits 

<code>rails g permits</code>

Configure Rails to autoload permits files

Inside config/application.rb
<code>config.autoload_paths += %W(#{Rails.root}/app/permits)</code>    

## Configure and generate roles

Add :admin_flag role strategy to User model

<code>rails g mongo_mapper:roles User --strategy admin_flag</code> 

<code>rails s</code>

*Module RoleStrategy::MongoMapper::RoleString has not been registered*

Add to user at the top:
<pre>
  use_roles_strategy :admin_flag
</pre>

Note: Should this be added (as an option?) to the Roles generator?

## Add Devise protection

In Welcome controller:

<code>before_filter :authenticate_user!</code> 

## Add Default user (optional)

Edit 'db/seeds.rb'
<pre>
  User.delete_all
  user = User.create(:email => 'kmandrup@gmail.com', :password => '123456', :password_confirmation => '123456')  
</pre>

Create 'lib/tasks/db.rake'
<pre>
  namespace :db do
    task :seed => :environment do
      load "#{Rails.root}/db/seeds.rb"
    end
  end  
</pre> 

<code>rake db:seed</code>     

## Test application

Start web server
<code>rails s</code>

In browser go to: localhost:3000/welcome/index

This should redirect to the Devise 'Sign up' form :) 

## Scaffold some app code

Now off to test the Cream functionality

Scaffold a Blog model using the mongo_mapper:model generator from *rails3-generators* (included by *mm-devise*)
A Blog consists of Posts, with an :index action listing all blog Posts, and :show to show an individual blog Post 
<code>rails g scaffold Post title:string body:string --orm mongo_mapper</code>

Inside 'app/views/posts/index.erb.html':
<pre>
  <%= show_link post %>
  <%= edit_link post %>
  <%= delete_link post %>
</pre>

Now see if the permissions work