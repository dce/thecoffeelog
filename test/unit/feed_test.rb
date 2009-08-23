require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  context "A feed" do
    should_validate_presence_of :url
    should_have_many :subscriptions, :users

    context "being created from a user url" do
      setup do
        @feed = Feed.create(:unverified_url => "http://www.nytimes.com/")
      end

      should "return a vaild feed from NY Times homepage url" do
        assert_equal @feed.url, "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
      end

      should "return the NY Times homepage feed name" do
        assert_equal @feed.title, "NYT &gt; Home Page"
      end
    end

    context "with a sent entry" do
      setup do
        @feed = Factory(:feed)
        entry_data = @feed.send(:feed_data).entries
        entry = @feed.entries.from_feedtools(entry_data[2])
        entry.mark_as_last_sent
        @feed.reload
      end

      context "updating" do
        setup do
          @feed.fetch_updates
        end

        should_change "@feed.entries.count", :by => 2
        should_change "@feed.reload.last_sent_entry_hash"
      end

      context "and an inaccurate hash" do
        setup do
          @feed.update_attribute(:last_sent_entry_hash, nil)
          @feed.fetch_updates
        end

        should_change "@feed.entries.count", :by => 2
        should_change "@feed.reload.last_sent_entry_hash"

        should "reset hash" do
          assert @feed.reload.last_sent_entry_hash.present?
        end
      end
    end
  end
end
