class PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.where(:slug => params[:slug]).first if params[:slug]
  end

end
