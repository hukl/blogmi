namespace :blogmi do
  
  desc "import wordpress data from mysql to current db"
  task :import_wp_posts => :environment do
    
    $connection_options = {
      :adapter => "mysql",
      :encoding => "utf8",
      :host => "localhost",
      :username => "root",
      :password => "",
      :database => "smyck_de"
    }
    
    class WpPost < ActiveRecord::Base
      self.establish_connection($connection_options)
      set_table_name "wp_posts"
      
      
    end
    
    Post.delete_all
    
    WpPost.where(:post_parent => 0).each do |wp_post|
      Post.create!(
        :title        => wp_post.post_title,
        :body         => wp_post.post_content,
        :published_at => wp_post.post_date,
        :slug         => wp_post.post_name
      )
    end
    
  end
  
end