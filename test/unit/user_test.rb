require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "A user" do
    setup do
      @user = Factory(:user)
    end

    should_validate_presence_of :email
    should_validate_uniqueness_of :email
    should_have_many :subscriptions, :feeds

    should "generate an access token" do
      assert @user.access_token.present?
    end

    should "be inactive by default" do
      assert !@user.active?
    end

    should "activate" do
      @user.activate!
      assert @user.active?
    end
  end

  context "The User class" do
    setup do
      @user1 = Factory(:user)
      @user2 = Factory(:user)
      @feed  = Factory(:feed)
      @user1.feeds << @feed
    end

    should "find a list of users with entries" do
      Factory(:entry, :feed => @feed)
      assert_equal [@user1], User.with_entries
    end
  end
end
