module CreepyCrawler

	# The base type for all pages to be crawled.
	# One common type is already included: IndexPage
	# You can define your own page types by inheriting from Page (or any type that inherits from page).
	# Place your page types in app/crawler/pages
	class Page
		# 8======= Fields ========D
		# type: The ruby class for the type of page this is.  Used by ActiveRecord single table inheritance.
		# request_url: A string representing everything after the protocol and hostname on the URL.  Ex.  /home/things/1?some=params&here=true
		# hash: A request_url.hash ^ website_id.hash Indexed for her pleasure
		# website_id: foreign key to the website on which this uri is found
		# last_loaded_at: Exactly what it sounds like
		# load_count: Total times fetched from the internets
		# last_load_was_error: true/false Also pretty clear :P
	end

end