require 'yaml'
require 'rubygems'
require 'nokogiri'

$database_options = YAML.load(
  File.open(
    File.join( Rails.root, "config", "database.yml" )
  )
)

namespace :blogmi do
  
  desc "Convert MySQL latin1 utf8 utf8 to utf8"
  task :fix_double_encodings => :environment do
    
    
    
    class WpComment < ActiveRecord::Base
      self.establish_connection($database_options["wordpress"])
      set_table_name "wp_comments"
      
      set_primary_key 'ID'
      
      belongs_to :wp_post, :foreign_key => 'comment_post_ID'
    end
    
    class WpPost < ActiveRecord::Base
      self.establish_connection($database_options["wordpress"])
      set_table_name "wp_posts"
      
      set_primary_key 'ID'
      
      has_many :wp_comments, :foreign_key => 'comment_post_ID'
    end
    
   
    WpPost.connection.execute("alter table wp_posts modify wp_posts.post_title longtext character set latin1;")
    WpPost.connection.execute("alter table wp_posts modify wp_posts.post_title blob;")
    WpPost.connection.execute("alter table wp_posts modify wp_posts.post_title longtext character set utf8;")
    WpPost.connection.execute("alter table wp_posts modify wp_posts.post_content longtext character set latin1;")
    WpPost.connection.execute("alter table wp_posts modify wp_posts.post_content blob;")
    WpPost.connection.execute("alter table wp_posts modify wp_posts.post_content longtext character set utf8;")
    WpPost.connection.execute("alter table wp_comments modify wp_comments.comment_author longtext character set latin1;")
    WpPost.connection.execute("alter table wp_comments modify wp_comments.comment_author blob;")
    WpPost.connection.execute("alter table wp_comments modify wp_comments.comment_author longtext character set utf8;")
    WpPost.connection.execute("alter table wp_comments modify wp_comments.comment_content longtext character set latin1;")
    WpPost.connection.execute("alter table wp_comments modify wp_comments.comment_content blob;")
    WpPost.connection.execute("alter table wp_comments modify wp_comments.comment_content longtext character set utf8;")
  end
  
  desc "import wordpress data from mysql to current db"
  task :import_wp_posts => :environment do
    
    Post.delete_all
    Comment.delete_all
    
    $database_options = YAML.load(
      File.open(
        File.join( Rails.root, "config", "database.yml" )
      )
    )
    
    class WpComment < ActiveRecord::Base
      self.establish_connection($database_options["wordpress"])
      set_table_name "wp_comments"
      
      set_primary_key 'ID'
      
      belongs_to :wp_post, :foreign_key => 'comment_post_ID'
    end
    
    class WpPost < ActiveRecord::Base
      self.establish_connection($database_options["wordpress"])
      set_table_name "wp_posts"
      
      set_primary_key 'ID'
      
      has_many :wp_comments, :foreign_key => 'comment_post_ID'
    end
    
    WpPost.where(:post_parent => 0).each do |wp_post|
      post = Post.create!(
        :title        => wp_post.post_title,
        :body         => wp_post.post_content,
        :published_at => wp_post.post_date,
        :slug         => wp_post.post_name,
        :permalink    => wp_post.guid
      )
      
      ActiveRecord::Base.record_timestamps = false
      
      wp_post.wp_comments.each do |wp_comment|
        post.comments.create!(
          :author         => wp_comment.comment_author,
          :author_email   => wp_comment.comment_author_email,
          :author_url     => wp_comment.comment_author_url,
          :author_ip      => wp_comment.comment_author_IP,
          :author_agent   => wp_comment.comment_agent,
          :body           => wp_comment.comment_content,
          :approved       => wp_comment.comment_approved,
          :comment_type   => wp_comment.comment_type,
          :created_at     => wp_comment.comment_date
        )
        
        ActiveRecord::Base.record_timestamps = true
      end
    end
    
  end
  
  desc "Fix invalid ahrefs in wordpress posts"
  task :fix_urls => :environment do
    Post.all.each do |post|
      
      doc = Nokogiri::HTML.parse(post.body)
      doc.css("a").each {|element| element[:href].sub("&", "%26")}
      post.update_attributes(:body => doc.at("body").content)
    end
    
  end
  
end