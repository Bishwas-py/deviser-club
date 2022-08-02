class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    tags = params[:post][:raw_tags].split(",")
    puts "tags = #{tags}"
    # @post.tags.find_or_create_by(name: params[:tag])
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post) }
        format.json { render :show, status: :created, location: @post }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("error_explanation", partial: 'components/errors', locals: { errors: @post.errors })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    create_or_delete_post_tags(@post, params[:post][:tags],)
    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity, notice: "Post was not updated." }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def create_or_delete_post_tags(post, tags)
    post.taggables.destroy_all
    tag_names = tags.strip.split(",")
    tag_names.each do |tag_name|
      if tag_names.length > 0
        tag = Tag.find_by(name: tag_name.capitalize)
        if tag.nil?
          tag = Tag.create(name: tag_name, created_by: current_user)
        end
        post.tags << tag
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :id, :tags)
  end
end
