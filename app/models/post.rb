class Post < ActiveRecord::Base
  
  default_scope :order => "published_at DESC"
  
  def public_path
    path = published_at.strftime("%Y/%m/%d/#{slug}")
  end
  
end
