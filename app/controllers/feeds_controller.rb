class FeedsController < ApplicationController
  before_filter :load_user

  def index
    unless @user.active?
      @user.update_attribute(:active, true)
      @first_visit = true
    end
  end

  def create
    @link  = params[:feed][:url]
    @feed = Feed.for(@link)

    if @feed.valid?
      @feed.save if @feed.new_record?
      @user.feeds << @feed
      redirect_to user_feeds_url(@user)
    else
      render :action => "index"
    end
  end

  def destroy
    @user.subscriptions.find(params[:id]).destroy
    redirect_to user_feeds_url(@user)
  end

  private

  def load_user
    @user = User.find_by_access_token!(params[:access_token])
  end
end
