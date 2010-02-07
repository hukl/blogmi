class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :author
      t.string :author_email
      t.author_url :
      t.author_ip :
      t.author_agent :
      t.text :body
      t.boolean :approved
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
