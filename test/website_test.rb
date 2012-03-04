$:.unshift '.';require File.dirname(__FILE__) + '/test_helper'


class SomeWebsite < CreepyCrawler::Website

end

class AnotherWebsite < CreepyCrawler::Website

end

class WebsiteTest < ActiveSupport::TestCase 
  
  should "have a type" do
    website = CreepyCrawler::Website.create(:name => "Blah", :url => "http://asdfs.com")
    assert website.new_record?
    assert_equal ["can't be blank"], website.errors[:type]
  end

  should "have a name" do
    website = SomeWebsite.create(:url => "http://asdfs.com")
    assert website.new_record?
    assert_equal ["can't be blank"], website.errors[:name]
  end

  should "have a url" do
    website = SomeWebsite.create(:name => "Blah")
    assert website.new_record?
    assert_equal ["can't be blank"], website.errors[:url]
  end

  should "have a valid url" do
    website = SomeWebsite.create(:name => "Blah", :url => "asdfs.com")
    assert website.new_record?
    assert_equal ["isn't a valid URI::HTTP or URI::HTTPS"], website.errors[:url]
  end

  should "not have a request_uri on url" do
    website = SomeWebsite.create(:name => "Blah", :url => "http://asdfs.com/something")
    assert website.new_record?
    assert_equal ["must be the root url for the website, please remove '/something'"], website.errors[:url]
  end

  context "an existing website" do
    setup do
      @website = SomeWebsite.create(:name => "Blah", :url => "http://asdfs.com", :settings => {:custom_settings => true})
    end

    should "create corretly with correct defaults" do
      assert_equal @website, SomeWebsite.first
      assert_equal false, @website.enabled
      expected_settings = {:days_before_refresh_error_pages => nil, :days_before_refresh_index_pages => 7, :custom_settings => true}
      assert_equal expected_settings, @website.settings
    end

    should "prevent name conflicts" do
      dupe = AnotherWebsite.create(:name => "Blah", :url => "http://asdfs.xxx")
      assert dupe.new_record?
      assert_equal ["has already been taken"], dupe.errors[:name]
    end

    should "prevent url conflicts" do
      dupe = AnotherWebsite.create(:name => "Blahxx", :url => "http://asdfs.com")
      assert dupe.new_record?
      assert_equal ["has already been taken"], dupe.errors[:url]
    end

    should "prevent type conflicts" do
      dupe = SomeWebsite.create(:name => "Blahxx", :url => "http://asdfs.xxx")
      assert dupe.new_record?
      assert_equal ["has already been taken"], dupe.errors[:type]
    end

  end

end
