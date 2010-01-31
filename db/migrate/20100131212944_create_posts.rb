class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string    :title
      t.text      :excerpt
      t.text      :body
      t.integer   :author_id
      t.datetime  :published_at
      t.string    :slug
      t.string    :permalink

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
