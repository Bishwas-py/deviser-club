class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts or /posts.json
  def index
    @pagy, @posts = pagy(Post.published, items: 15)
  end

  def pagy_index
    @pagy, @posts = pagy(Post.published, items: 7)

    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.find_by(draft: true, user: current_user) || Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.find_by(draft: true, user: current_user) || Post.new(post_params.except(:tags))
    @post.title = post_params[:title]
    @post.body = post_params[:body]
    @post.draft = params[:commit].nil?

    create_or_delete_post_tags(@post, params[:post][:tags],)
    @post.user = current_user
    respond_to do |format|
      if @post.draft
        @post.skip_validations = true
        @post.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "error_explanation", partial: 'components/errors',
            locals: { errors: @post.errors })
        }
        format.turbo_stream
      else
        if @post.save
          @post.generate_og_image
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
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    create_or_delete_post_tags(@post, params[:post][:tags],)
    respond_to do |format|
      if @post.draft
        @post.draft = params[:commit].nil?
        @post.skip_validations = true
        @post.update(post_params.except(:tags))
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "error_explanation", partial: 'components/errors',
            locals: { errors: @post.errors })
        }
      else
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
        tag = Tag.find_by(name: tag_name)
        if tag.nil?
          tag = Tag.create(name: tag_name, created_by: current_user)
        end
        post.tags << tag
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :id, :tags)
  end
end
