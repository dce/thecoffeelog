set :repository, "git@github.com:railsrumble/rr09-team-133.git"
set :deploy_to, "/var/www/#{application}"

role :web, "#{application}.com"
role :app, "#{application}.com"
role :db, "#{application}.com", :primary => true

# Uncomment one of these lines:
# set :user, "apache"   # for RHEL hosts
set :user, "www-data" # for Ubuntu hosts

set :deploy_via, :rsync_with_remote_cache
set :local_cache, ".rsync_cache/production"
