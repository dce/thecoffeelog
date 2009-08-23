class FeedMailer < ActionMailer::Base
  def coffee_log(user)
    recipients    user.email
    from          "updates@thecoffeelog.com"
    subject       "Your CoffeeLog for #{Date.today}"
    body          :user => user
    content_type  "text/html"
  end

  def activation_email(user, failure)
    recipients    user.email
    from          "activate@thecoffeelog.com"
    subject       "Activate Your CoffeeLog"
    body          :user => user, :failure => failure
    content_type  "text/html"
  end

  def subscription_results(user, success, failure)
    recipients    user.email
    from          "updates@thecoffeelog.com"
    subject       "Additions to your CoffeeLog"
    body          :user => user, :success => success, :failure => failure
    content_type  "text/html"
  end
end
