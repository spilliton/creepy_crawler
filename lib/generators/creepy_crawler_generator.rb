# https://github.com/norman/friendly_id/blob/master/lib/generators/friendly_id_generator.rb

require 'rails/generators'
require "rails/generators/active_record"

# This generator adds a migration for all the creepy crawler objects
class CreepyCrawlerGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration

  source_root File.expand_path('../../friendly_id', __FILE__)

  # Copies the migration template to db/migrate.
  def copy_files(*args)
    migration_template 'migration.rb', 'db/migrate/create_friendly_id_slugs.rb'
  end

end
