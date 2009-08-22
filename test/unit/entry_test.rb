require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  context "An entry" do
    setup do
      @entry = Factory(:entry)
    end

    should_belong_to :feed
    
    should_validate_presence_of :title, :link, :unique_key, :feed
    should_validate_uniqueness_of :unique_key
    
    should "generate a unique key" do
      assert @entry.unique_key.present?
    end
  end
end
