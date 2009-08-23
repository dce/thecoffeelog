ActionController::Routing::Routes.draw do |map|
  map.namespace :user, :path_prefix => ':access_token', :namespace => nil do |user|
    user.root :controller => 'feeds', :action => 'index'
    user.resources :feeds
  end
end
