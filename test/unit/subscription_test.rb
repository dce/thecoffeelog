require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  context "A subscription" do
    should_belong_to :user, :feed
    should_validate_presence_of :user, :feed
  end
end
