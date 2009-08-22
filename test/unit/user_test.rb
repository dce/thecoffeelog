require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "A user" do
    setup do
      @user = Factory(:user)
    end

    should_validate_presence_of :email
    should_validate_uniqueness_of :email

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
end
