namespace :db do
  task :seed => :environment do
    load "#{Rails.root}/db/seeds.rb"
  end
end
