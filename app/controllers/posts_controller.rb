class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Post.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

   def update
     @group = Post.find(params[:id])

     @post.update(post_params)

     redirect_to groups_path, notice: "Update Success"
   end

   def destroy
     @group = Post.find(params[:id])
     @group.destroy
     flash[:alert] = "Post deleted"
     redirect_to groups_path
   end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
