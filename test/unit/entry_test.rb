require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  context "An entry" do
    setup do
      @entry = Factory(:entry)
    end
    
    should_validate_presence_of :title, :link, :unique_key, :feed_id
    should_validate_uniqueness_of :unique_key
    
  end
end
