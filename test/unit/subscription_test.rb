require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  context "A subscription" do
    should_belong_to :user, :feed
    should_validate_presence_of :user, :feed

    context "being created" do
      setup do
        @user = Factory(:user)
      end

      context "being created for a new feed" do
        setup do
          @sub = @user.subscriptions.create(:feed => Feed.for("http://www.nytimes.com"))
        end

        should_change "@user.feeds.count", :by => 1
        should_change "Feed.count", :by => 1

        should "set subscription title to feed title" do
          assert_equal "NYT &gt; Home Page", @sub.title
        end
      end

      context "being created for an existing feed" do
        setup do
          @feed = Feed.create(:url_from_user => "http://www.nytimes.com")
        end

        context "subscribing to it" do
          setup do
            @user.subscriptions.create(:feed => Feed.for("http://www.nytimes.com"))
          end

          should_change "@user.feeds.count", :by => 1
          should_not_change "Feed.count"
        end
      end
      
      context "from an email" do
        setup do
          @email = TMail::Mail.parse(File.read("#{Rails.root}/test/sample_email.txt"))
        end
        
        should "create new subscriptions and feeds" do
          assert_difference "Subscription.count", 2 do
            Subscription.create_from_email_message(@email.from.to_s, @email.body.to_s)
          end
          assert_equal "ren@packagetrackapp.com", Subscription.last.user.email
          assert_equal "Slashdot", Subscription.last.feed.title
          assert_equal "http://rss.slashdot.org/Slashdot/slashdot", Subscription.last.feed.url
          assert_equal "NYT &gt; Home Page", Subscription.first.feed.title
          assert_equal "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml", Subscription.first.feed.url
        end
      end
    end
  end
end
