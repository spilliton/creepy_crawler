ActiveRecord::Schema.define do

  create_table "creepy_crawler_websites", :force => true do |t|
    t.string   "type", :limit => 40
    t.string   "name"
    t.string   "url"
    t.boolean  "enabled", :default => false
    t.string   "settings"
    t.timestamps
  end
  add_index(:creepy_crawler_websites, :type)
  add_index(:creepy_crawler_websites, :url)

  create_table "creepy_crawler_pages", :force => true do |t|
    t.string   "type", :limit => 40
    t.integer	 "website_id"
    t.string	 "request_url"
    t.integer  "load_count", :default => 0
    t.boolean  "last_load_was_error", :default => false
    t.datetime "last_loaded_at", :default => nil
    t.integer  "hash"
    t.timestamps
  end
  add_index(:creepy_crawler_pages, :type)
  add_index(:creepy_crawler_pages, :website_id)
  add_index(:creepy_crawler_pages, :hash)
  add_index(:creepy_crawler_pages, :last_loaded_at)
  add_index(:creepy_crawler_pages, :load_count)
  add_index(:creepy_crawler_pages, :last_load_was_error)
   
end