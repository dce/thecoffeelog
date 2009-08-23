class FeedsController < ApplicationController
  before_filter :load_user

  def index
    unless @user.active?
      @user.update_attribute(:active, true)
      @first_visit = true
    end
  end

  def create
    @url  = params[:feed][:url]
    @feed = Feed.for(@url)

    if @feed
      @feed.save
      @user.feeds << @feed
    else
      flash[:notice] = "We couldn't find any feeds for <strong>#{@url}</strong>. Sorry!"
    end

    redirect_to user_feeds_url(@user)
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
