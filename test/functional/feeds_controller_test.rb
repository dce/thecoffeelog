require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  context "A FeedsController" do
    setup do
      @user = Factory(:user)
    end

    context "on GET to :index" do
      context "for the first time" do
        setup do
          get :index, :access_token => @user.access_token
        end

        should_respond_with :success
        should_render_template :index
        should_change "@user.reload.active?", :to => true
      end
    end

    context "on POST to :create" do
      setup do
        post :create, :access_token => @user.access_token,
          :feed => { :url => "http://nytimes.com" }
      end

      should_redirect_to("feed list") { user_feeds_url(@user) }
      should_change "@user.feeds.count", :by => 1
    end

    context "with an existing feed" do
      setup do
        @sub = Factory(:subscription, :user => @user)
      end

      context "on DELETE to :destroy" do
        setup do
          delete :destroy, :access_token => @user.access_token, :id => @sub.id
        end

        should_redirect_to("feed list") { user_feeds_url(@user) }
        should_change "@user.feeds.count", :by => -1
      end
    end
  end
end
