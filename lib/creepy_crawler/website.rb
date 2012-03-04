require 'URI'

module CreepyCrawler

	# A website is a site you intenet to crawl.
	# You should create a file in app/crawler/sites/ for each site you intend to crawl and make it inherit from Website. 
	class Website < ActiveRecord::Base
		# 8======= Fields ========D
		#  name: Unique name to represent the website you want to crawl
		#  type: A ruby class name to be used with standard ActiveRecord single table inheritance.
		#  url: Fully qualified host name with the proper http protocol prepended.  All links on site must be under this domain.  Ex. http://www.comparevinyl.com
		#  enabled: A boolean flag for disabling / enabling crawls of this site's links.
		#  settings: A hash of crawling options for this site.  They should generally pertain to crawl options.  The required defaults are:
		#       {:days_before_refresh_error_pages => nil, :days_before_refresh_index_pages => 7}
		#        A nil value means you never wish to re-load a page of the specified type.  An integer specifies how many days (at minimum) to ignore pages of that time when deciding what pages to crawl.
		#        You can add refresh page preferences for any types you create by keeping to the naming convention and the engine will take then into account.

		# to prevent any table name clashes that could occur
		set_table_name "creepy_crawler_websites"

		validates :name, :type, :url, :presence => true, :uniqueness => true
		validate :url_is_correctly_formed
		def url_is_correctly_formed
			return unless uri
			unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
				self.errors.add(:url, "isn't a valid URI::HTTP or URI::HTTPS")
				return
			end
			unless uri.request_uri == "/"
				self.errors.add(:url, "must be the root url for the website, please remove '#{uri.request_uri}'")
			end
		end

		serialize :settings
		before_save :ensure_required_settings_exist
		def ensure_required_settings_exist
			self.settings = {} if self.settings.nil?
			self.settings[:days_before_refresh_error_pages] = nil unless self.settings.has_key?(:days_before_refresh_error_pages)
			self.settings[:days_before_refresh_index_pages] = 7 unless self.settings.has_key?(:days_before_refresh_index_pages)
		end

		before_save :remove_trailing_url_slash
		def remove_trailing_url_slash
			url.chop! if url[-1] == "/"
		end

		def uri
			URI(url) if url
		end

	end


end