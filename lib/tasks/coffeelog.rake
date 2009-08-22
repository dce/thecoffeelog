namespace :coffeelog do
  require File.join(RAILS_ROOT, 'config', 'environment')

  desc "Retrieve the latests posts"
  task :update_feeds do
    Feed.all.each(&:fetch_updates)
  end

  desc "Send emails of updates"
  task :send_emails do
    User.active.with_entries.each do |user|
      p user.inspect
    end
  end
end