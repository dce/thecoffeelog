set :application, 'thecoffeelog'
set :use_sudo, false
set :default_stage, 'production'
set :scm, :git

#set :campfire_notify, "#{application}"
before "deploy", "daemons:stop"
after "deploy:update_code", "app:symlink"
after "deploy:update_code", "daemons:start"


namespace :app do
  desc "Make symlinks"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :daemons do
  desc "Start daemons"
  task :start do
    run "cd #{current_path}/lib && RAILS_ENV=production /usr/local/bin/ruby mail_queue_processor_control.rb start"
  end
  
  desc "Stop daemons"
  task :stop do
    run "cd #{current_path}/lib && RAILS_ENV=production /usr/local/bin/ruby mail_queue_processor_control.rb stop"
  end
end