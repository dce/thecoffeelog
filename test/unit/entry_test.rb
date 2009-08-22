require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  context "An entry" do
    setup do
      @entry = Factory(:entry)
    end

    should_belong_to :feed

    should_validate_presence_of :title, :link, :unique_key, :published_at, :feed
    should_validate_uniqueness_of :unique_key

    should "generate a unique key" do
      assert @entry.unique_key.present?
    end
  end

  context "The Entry class" do
    setup do
      @feed = Factory(:feed)
    end

    should "generate an entry from a feedtools item" do
      data  = FeedTools::Feed.open('http://www.slashdot.org/index.rss')
      entry = @feed.entries.from_feedtools(data.items.first)
      assert entry.valid?
    end
  end
end
