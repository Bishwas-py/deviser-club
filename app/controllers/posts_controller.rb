class PostsController < ApplicationController
  before_action :load_post, only: [:show] # required for proper functioning of cancancan
  before_action :set_post, only: %i[ edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  authorize_resource

  def index
    @pagy, @posts = pagy(Post.published, items: 15)
  end

  def pagy_index
    @pagy, @posts = pagy(Post.published, items: 7)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new(user: current_user)
  end

  def edit
  end

  def create
    @post = Post.new(post_params.except(:tags))
    create_or_delete_post_tags(@post, params[:post][:tags],)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post) }
        format.json { render :show, status: :created, location: @post }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "error_explanation", partial: 'components/errors',
            locals: { errors: @post.errors })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    create_or_delete_post_tags(@post, params[:post][:tags],)
    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "error_explanation", partial: 'components/errors',
            locals: { errors: @post.errors })
        }
        format.html { render :edit, status: :unprocessable_entity, notice: "Post was not updated." }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def load_post
    # Load post is required for authorization of posts with cancancan
    @post = Post.friendly.find(params[:id])
  end

  def create_or_delete_post_tags(post, tags)
    post.taggables.destroy_all
    tag_names = tags.strip.split(",")
    tag_names.each do |tag_name|
      if tag_names.length > 0
        tag = Tag.find_by(name: tag_name)
        if tag.nil?
          tag = Tag.create(name: tag_name, created_by: current_user)
        end
        post.tags << tag
      end
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :id, :tags)
  end
end
