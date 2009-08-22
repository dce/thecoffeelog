require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  context "A feed" do
    should_validate_presence_of :url
    should_have_many :subscriptions, :users
  end
end
