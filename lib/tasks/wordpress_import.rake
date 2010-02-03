require 'yaml'

namespace :blogmi do
  
  desc "import wordpress data from mysql to current db"
  task :import_wp_posts => :environment do
    
    $database_options = YAML.load(
      File.open(
        File.join( Rails.root, "config", "database.yml" )
      )
    )
    
    class WpPost < ActiveRecord::Base
      self.establish_connection($database_options["wordpress"])
      set_table_name "wp_posts"
    end
    
    Post.delete_all
    
    WpPost.where(:post_parent => 0).each do |wp_post|
      Post.create!(
        :title        => wp_post.post_title,
        :body         => wp_post.post_content,
        :published_at => wp_post.post_date,
        :slug         => wp_post.post_name,
        :permalink    => wp_post.guid
      )
    end
    
  end
  
end