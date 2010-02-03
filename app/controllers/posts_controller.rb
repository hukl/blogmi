class PostsController < ApplicationController

  def index
    @posts = Post.all.paginate :page => (params[:page] || 1)
  end
  
  def show
    @post = Post.where(:slug => params[:slug]).first if params[:slug]
  end

end
