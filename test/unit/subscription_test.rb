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
          @user.subscriptions.create(:feed => Feed.for("http://www.nytimes.com"))
        end

        should_change "@user.feeds.count", :by => 1
        should_change "Feed.count", :by => 1
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
    end
  end
end
