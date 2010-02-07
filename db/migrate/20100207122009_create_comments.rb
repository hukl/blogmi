class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer  :post_id
      t.string   :author
      t.string   :author_email
      t.string   :author_url
      t.string   :author_ip
      t.string   :author_agent
      t.text     :body
      t.boolean  :approved
      t.integer  :user_id
      t.string   :comment_type

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
