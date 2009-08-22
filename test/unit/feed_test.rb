require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  context "A feed" do
    setup do
      @feed = Feed.create(:url_from_user => "http://www.nytimes.com/")
    end

    should_validate_presence_of :url
    
    should "return a vaild feed from NY Times homepage url" do
      assert_equal @feed.url, "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
    end
    
    should "return the NY Times homepage feed name" do
      assert_equal @feed.title, "NYT &gt; Home Page"
    end
  end
end
