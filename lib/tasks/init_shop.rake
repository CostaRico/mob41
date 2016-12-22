task :init_shop do 
	system "RAILS_ENV=production bundle exec rails g spree:install --user_class=Spree::User"
	system "RAILS_ENV=production bundle exec rails g spree:auth:install"
	system "RAILS_ENV=production bundle exec rails g spree_gateway:install"
	system "RAILS_ENV=production bundle exec rails g spree_i18n:install"
end