class FeedMailer < ActionMailer::Base
  def coffee_log(user)
    recipients  user.email
    from        "updates@thecoffeelog.com"
    subject     "Your CoffeeLog for #{Date.today}"
    body        :user => user
  end
end
