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

  desc "Handle new incoming messages"
  task(:poll_maildir => :environment) do
    maildir = TMail::Maildir.new("/var/www/Maildir")

    mailbox.each_new_port do |m|
      mail = TMail::Mail.new(m)
      Subscription.create_from_email_message(mail.from.to_s, mail.body.to_s)
    end
  end
end