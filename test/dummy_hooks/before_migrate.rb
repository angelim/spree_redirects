# Install spree's migrations
rake "spree:install:migrations"

# Mount the Spree::Core routes
insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

# For testing middleware
gsub_file "config/environments/test.rb", "show_exceptions = false", "show_exceptions = true"

# remove all stylesheets except core  
%w(admin store).each do |ns|
  template "#{ns}/all.js",  "app/assets/javascripts/#{ns}/all.js",  :force => true
  template "#{ns}/all.css", "app/assets/stylesheets/#{ns}/all.css", :force => true
end
 
# Fix sass load error by using the converted css file
template "store/screen.css", "app/assets/stylesheets/store/screen.css"

# Install spree essentials & example extension
run "bundle exec rails g spree_redirects:install"
