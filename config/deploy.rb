set :application, 'thecoffeelog'
set :use_sudo, false
set :default_stage, 'production'
set :scm, :git

#set :campfire_notify, "#{application}"

after "deploy:update_code", "app:symlink"

namespace :app do
  desc "Make symlinks"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end