namespace :coffeelog do
  desc "Retrieve the latests posts"
  task(:update_feeds => :environment) do
    Feed.all.each(&:fetch_updates)
  end

  desc "Send emails of updates"
  task(:send_emails => :environment) do
    User.active.with_entries.each do |user|
      FeedMailer.deliver_coffee_log(user)
    end
  end

  desc "Delete stale entries"
  task(:clear_entries => :environment) do
    Entry.delete_all
  end
end